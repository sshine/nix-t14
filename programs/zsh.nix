{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      # Typical: $username, $hostname, $directory, $character
      # Special: $nix_shell, $git_*
      format = ''$battery$username$hostname$directory$nix_shell$git_branch$git_commit$git_state$git_status$character'';
      username = {
        format = "[$user]($style)";
        style_root = "red bold";
        style_user = "green bold";
      };
      hostname = {
        format = "@[$hostname]($style)";
        style = "green bold";
        ssh_only = false;
        ssh_symbol = "";
        trim_at = ".";
      };
      directory = {
        format = ":[$path]($style)[$read_only]($read_only_style) ";
        style = "";
        home_symbol = "~";
        read_only = " 🔒";
        read_only_style = "red";
        truncate_to_repo = false;
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "green bold";
      };
      character = {
        # success_symbol = "[>](bold green)";
        # error_symbol = "[>](bold red)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    enableGlobalCompInit = true;

    # autosuggetions.enable = true;
    # autosuggetions.strategy = [ "history" "completion" ];

    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [ "main" "brackets" ];

    histSize = 100000;

    # See `man zshoptions` for more details.
    setOptions = [
      # Remove duplicates continuously from command history (preserve newest entry).
      "HIST_IGNORE_DUPS"

      # Instantly share command history between all active shells.
      "SHARE_HISTORY" # Alternative to: "APPEND_HISTORY", "INC_APPEND_HISTORY",

      # Disable ^S and ^Z for less accidental freezing.
      "FLOW_CONTROL"

      # Save timestamp and duration of each command in command history.
      "EXTENDED_HISTORY"
    ];

    shellAliases = {
      rm = "rm -iv";
      ls = "eza -lg";
      tree = "eza -lgT";
      gs = "git status";
      gd = "git diff";
      gdc = "git diff --cached";
      gap = "git add -p";
      gl = "git log";
      gpr = "git pull --rebase";
      gcp = "git cherry-pick";
    };

    interactiveShellInit = ''
      # MacOS
      bindkey '^[[7~' beginning-of-line
      bindkey '^[[8~' end-of-line

      # Linux
      bindkey '^[[1;3D' beginning-of-line  # alt+left
      bindkey '^[[1;3C' end-of-line        # alt+right
      bindkey '^[[1;5D' backward-word      # ctrl+left
      bindkey '^[[1;5C' forward-word       # ctrl+right

      # Both
      bindkey '^R' history-incremental-search-backward
      bindkey '^U' kill-whole-line
      bindkey '^Y' yank

      # Compensate for modern terminals
      export TERM=xterm-256color

      # Prompt
      eval "$(starship init zsh)"
    '';
    };
}
