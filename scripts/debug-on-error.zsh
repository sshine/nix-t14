# When an interactive command fails, offer to hand it to claude for debugging.
#
# Source this from an interactive zsh, or let the nixos zsh module do it:
#   source ./scripts/debug-on-error.zsh

typeset -g DEBUG_ON_ERROR_CMD=${DEBUG_ON_ERROR_CMD:-claude}
typeset -g DEBUG_ON_ERROR_LINES=${DEBUG_ON_ERROR_LINES:-5000}
typeset -g DEBUG_ON_ERROR_INLINE=${DEBUG_ON_ERROR_INLINE:-40}
typeset -g DEBUG_ON_ERROR_TIMEOUT=${DEBUG_ON_ERROR_TIMEOUT:-2}

# 130 is ^C, 146/148 are ^Z; none of them are failures.
typeset -ga DEBUG_ON_ERROR_IGNORE
(( $#DEBUG_ON_ERROR_IGNORE )) || DEBUG_ON_ERROR_IGNORE=(130 146 148)

# Commands that answer "no" with a non-zero status rather than failing.
typeset -ga DEBUG_ON_ERROR_SKIP
(( $#DEBUG_ON_ERROR_SKIP )) || DEBUG_ON_ERROR_SKIP=(
  grep egrep fgrep rg ag diff colordiff cmp fd find pgrep test '[' '[[' true false ':'
)

typeset -g _debug_on_error_cmd=

# A terminal with no remote control configured may answer nothing at all, so
# never let reading the screen outlast the question we are about to ask.
_debug_on_error_ask_terminal() {
  if (( $+commands[timeout] )); then
    timeout --foreground "$DEBUG_ON_ERROR_TIMEOUT" "$@" 2>/dev/null
  else
    "$@" 2>/dev/null
  fi
}

# XDG_RUNTIME_DIR is tmpfs and goes away at logout, which is where a full
# record of terminal output belongs: it routinely holds tokens and other secrets.
_debug_on_error_logdir() {
  local dir=${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}/debug-on-error
  mkdir -p -m 700 -- "$dir" 2>/dev/null && print -r -- "$dir"
}

# Whatever printed the failure is still on screen, so read it back off the
# terminal rather than piping every command and costing it its tty.
_debug_on_error_capture() {
  local text=
  if [[ -n $KITTY_WINDOW_ID ]] && (( $+commands[kitten] )); then
    # last_cmd_output needs kitty's shell integration and is empty without it.
    text=$(_debug_on_error_ask_terminal kitten @ get-text --extent=last_cmd_output)
    # A refused or timed-out request fails; only retry when kitty answered nothing.
    if (( $? == 0 )) && [[ -z ${text//[[:space:]]/} ]]; then
      text=$(_debug_on_error_ask_terminal kitten @ get-text --extent=screen)
    fi
  elif [[ -n $TMUX ]] && (( $+commands[tmux] )); then
    text=$(_debug_on_error_ask_terminal tmux capture-pane -p -S "-$DEBUG_ON_ERROR_LINES")
  fi

  local -a lines
  lines=("${(@f)text}")
  while (( $#lines )) && [[ -z ${lines[-1]//[[:space:]]/} ]]; do
    lines=("${(@)lines[1,-2]}")
  done
  while (( $#lines )) && [[ -z ${lines[1]//[[:space:]]/} ]]; do
    shift lines
  done
  (( $#lines > DEBUG_ON_ERROR_LINES )) && lines=("${(@)lines[-DEBUG_ON_ERROR_LINES,-1]}")
  (( $#lines )) || return 0

  local dir
  dir=$(_debug_on_error_logdir) || return 0
  # mktemp both makes the name unique and creates the file 0600 with no race.
  # the prompt escape has to expand outside quotes; in them zsh ends ${...} early
  local stamp=${(%):-%D{%Y%m%d-%H%M%S}}
  local log
  log=$(mktemp "$dir/$stamp-XXXXXX.log" 2>/dev/null) || return 0
  print -rl -- "${lines[@]}" > "$log" || return 0

  print -r -- "$log"
}

_debug_on_error_prompt() {
  local exit_code=$1 cmd=$2 log=$3

  print -r -- "A command just failed in my shell. Help me debug it."
  print -r -- ""
  print -r -- "Working directory: $PWD"
  print -r -- "Exit code: $exit_code"
  print -r -- ""
  print -r -- "Command:"
  print -r -- '~~~sh'
  print -r -- "$cmd"
  print -r -- '~~~'

  [[ -n $log && -s $log ]] || return 0

  local count=$(wc -l < "$log")
  print -r -- ""
  if (( count > DEBUG_ON_ERROR_INLINE )); then
    print -r -- "Output: $count lines in $log, last $DEBUG_ON_ERROR_INLINE below."
  else
    print -r -- "Output: also in $log"
  fi
  print -r -- '~~~'
  tail -n "$DEBUG_ON_ERROR_INLINE" -- "$log"
  print -r -- '~~~'
}

_debug_on_error_preexec() {
  _debug_on_error_cmd=$1
}

_debug_on_error_precmd() {
  local exit_code=$?
  local cmd=$_debug_on_error_cmd
  _debug_on_error_cmd=

  (( exit_code )) || return 0
  [[ -n $cmd ]] || return 0
  [[ -o interactive && -t 0 ]] || return 0
  (( $+commands[${DEBUG_ON_ERROR_CMD%% *}] )) || return 0
  (( ${DEBUG_ON_ERROR_IGNORE[(Ie)$exit_code]} )) && return 0
  (( ${DEBUG_ON_ERROR_SKIP[(Ie)${${(z)cmd}[1]}]} )) && return 0

  # Read the screen before asking, or the question ends up in the capture.
  local log=$(_debug_on_error_capture)

  local answer
  if read -q "answer?[$exit_code] debug with ${DEBUG_ON_ERROR_CMD%% *}? [y/N] "; then
    print
    ${=DEBUG_ON_ERROR_CMD} "$(_debug_on_error_prompt "$exit_code" "$cmd" "$log")"
  else
    print
    [[ -n $log ]] && command rm -f -- "$log"
  fi
}

# Both hooks go in front: a precmd hook sees $? from the hook before it, so
# anything registered earlier (atuin, for one) would hide the real status.
precmd_functions=(_debug_on_error_precmd ${precmd_functions:#_debug_on_error_precmd})
preexec_functions=(_debug_on_error_preexec ${preexec_functions:#_debug_on_error_preexec})
