source $HOME/personal/config/zsh/path.zsh
source $HOME/personal/config/zsh/keybinds.zsh

export NVM_DIR="$HOME/.nvm"

# --- nvm lazy loader ---
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() { nvm "$@"; }
npm()  { nvm "$@"; }
npx()  { nvm "$@"; }
# --- nvm lazy loader ---

setopt autocd
setopt extendedglob
setopt nomatch
setopt notify
setopt correct
setopt interactivecomments

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt inc_append_history

setopt prompt_subst
setopt transient_rprompt

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%F{red}%b%F{blue})%f'
zstyle ':vcs_info:git:*' actionformats ' %F{blue}git:(%F{red}%b%F{blue}|%a)%f'
zstyle ':vcs_info:git:*+*' check-for-changes true
zstyle ':vcs_info:git:*+*' unstagedstr '%F{yellow}✗%F{blue}'

precmd() {
  git rev-parse --is-inside-work-tree &>/dev/null && vcs_info || vcs_info_msg_0_=""
}

PROMPT='%(?:%F{green}➜%f:%F{red}➜%f) %F{cyan}%c%f${vcs_info_msg_0_} '

if [[ -n "$TMUX" ]]; then
  cd .
fi
