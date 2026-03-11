{ ... }:
{
  flake.nixosModules.zsh =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.zsh;

      environment.systemPackages = with pkgs; [
        atuin
        eza
        git
        zsh
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        enableGlobalCompInit = true;

        syntaxHighlighting.enable = true;
        syntaxHighlighting.highlighters = [
          "main"
          "brackets"
        ];

        histSize = 100000;

        setOptions = [
          "HIST_IGNORE_DUPS"
          "SHARE_HISTORY"
          "FLOW_CONTROL"
          "EXTENDED_HISTORY"
        ];

        shellAliases = {
          rm = "rm -iv";
          ls = "eza -lg";
          tree = "eza -lgT";

          gs = "git status";
          gd = "git diff";
          gdc = "git diff --cached";
          gca = "git commit --amend";
          gcv = "git commit --verbose";
          gap = "git add -p";
          gl = "git log --decorate=short --color | less -R";
          gpr = "git pull --rebase";
          gcp = "git cherry-pick";
        };

        promptInit = ''
          autoload -U promptinit
          promptinit
          prompt off

          function git_branch_name() {
            branch=$(git symbolic-ref HEAD --short 2>/dev/null)
            if [ ! -z "$branch" ]; then
              echo -n " [%F{red}$branch%f]"
            fi
          }

          prompt='[%(!.%F{red}.%F{green})%m%f:%F{blue}%~%f]$(git_branch_name) %(!.%F{red}#%f.$) '

          setopt prompt_cr
          setopt prompt_sp
          setopt prompt_subst

          export PROMPT_EOL_MARK=""
        '';

        interactiveShellInit = ''
          touch $HOME/.zshrc

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

          export TERM=xterm-256color

          eval "$(atuin init zsh --disable-up-arrow)"
        '';
      };
    };
}
