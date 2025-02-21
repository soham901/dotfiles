# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash, ensure your $PATH is set correctly.
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme: Clean, minimal, and informative.
ZSH_THEME="powerlevel10k/powerlevel10k"  # Requires installation (see below).

# Random theme candidates (optional, if you prefer variety).
# ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster" "powerlevel10k/powerlevel10k")

# Case-insensitive completion for convenience.
HYPHEN_INSENSITIVE="true"

# Auto-update Oh My Zsh every 7 days without prompting.
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# Enable command auto-correction (e.g., corrects 'gti' to 'git').
ENABLE_CORRECTION="true"

# Show waiting dots for slow completions.
COMPLETION_WAITING_DOTS="true"

# Speed up git status checks for large repos.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Customize history timestamp format.
HIST_STAMPS="yyyy-mm-dd"

# Plugins for productivity (install additional ones as needed, see below).
plugins=(
  git            # Git shortcuts (e.g., `gco` for checkout).
  zsh-autosuggestions  # Suggests commands as you type (install required).
  zsh-syntax-highlighting  # Highlights commands in real-time (install required).
  fzf            # Fuzzy search for files/history (install fzf separately).
  docker         # Docker command completions.
  kubectl        # Kubernetes command completions (optional).
)

# Source Oh My Zsh.
source $ZSH/oh-my-zsh.sh

# User configuration

# Set language environment (uncomment if needed).
# export LANG="en_US.UTF-8"

# Preferred editor (nvim for local, vim for SSH).
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# Better history settings.
HISTSIZE=10000          # Number of commands stored in memory.
SAVEHIST=10000          # Number of commands saved to history file.
setopt HIST_IGNORE_DUPS # Don’t store duplicate commands.
setopt HIST_IGNORE_SPACE # Ignore commands starting with a space.

# Personal aliases for efficiency.
alias cls="clear"              # Clear terminal.
alias ll="ls -lah"             # Detailed directory listing (works with macOS/Linux).
alias gs="git status"          # Quick git status.
alias gc="git commit -m"       # Commit with message.
alias gp="git push"            # Push to remote.
alias reload="source ~/.zshrc" # Reload Zsh config.
alias zshconfig="$EDITOR ~/.zshrc" # Edit Zsh config.

# Custom functions
# Quick directory navigation with `cd` history.
function cd() {
  builtin cd "$@" && ls  # Run `ls` after every `cd`.
}

# Extract archives easily (e.g., `extract file.tar.gz`).
function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.gz)  tar xzf "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.rar)     unrar x "$1" ;;
      *)         echo "Unsupported archive format" ;;
    esac
  else
    echo "File not found: $1"
  fi
}

# Powerlevel10k configuration (create with `p10k configure` if installed).
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_BASE=$(which fzf)
