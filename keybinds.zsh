tmux-sessionizer() {
  local dir="$1"
  local name="$2"

  # Tmux does not have the same session name
  if ! tmux has-session -t="$name" 2>/dev/null; then
    tmux new-session -ds "$name" -c "$dir"
  fi

  # Session exists
  if [[ -n $TMUX ]]; then
    # Already in tmux
    tmux switch-client -t "$name"
  else
    # Not in tmux
    tmux attach -t "$name"
  fi
}

fzf_personal() {
  local sel selected_name

  sel=$(fd --type d --max-depth 2 . "$HOME/personal" | fzf) || return
  [[ -z $sel ]] && return

  selected_name=$(basename "$sel" | tr . _)

  BUFFER="tmux-sessionizer '$sel' '$selected_name'"
  zle accept-line
}
zle -N fzf_personal

fzf_home() {
  sel=$(fd --type d . "$HOME" | fzf) && [[ -n $sel ]] && cd "$sel"
  precmd
  zle reset-prompt && clear
}
zle -N fzf_home

bindkey '^p' fzf_personal
bindkey '^f' fzf_home

