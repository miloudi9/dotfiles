[[ $- != *i* ]] && return

[[ -f ~/.bashrc.secrets ]] && . ~/.bashrc.secrets

alias ls='exa'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vim='nvim'

export XDG_CURRENT_DESKTOP=Hyprland

export EDITOR=nvim

[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"

# Usage: trimsub <input.mp4> <start> <end> <output.mp4>
# Example: trimsub movie.mkv 01:23:00 01:25:30 clip.mp4
trimsub() {
  if [[ $# -ne 4 ]]; then
    echo "Usage: trimsub <input> <start> <end> <output>"
    echo "Example: trimsub movie.mkv 01:23:00 01:25:30 clip.mp4"
    return 1
  fi
  
  local in="$1"
  local start="$2"
  local end="$3"
  local out="$4"
  
  # Check if input file exists
  if [[ ! -f "$in" ]]; then
    echo "Error: Input file '$in' not found"
    return 1
  fi
  
  ffmpeg \
    -i "$in" \
    -ss "$start" -to "$end" \
    -c:v libx264 -crf 28 -preset medium \
    -c:a aac -b:a 128k \
    -movflags +faststart \
    "$out"
}

[[ -f ~/.completion-for-pnpm.bash ]] && . ~/.completion-for-pnpm.bash

export PATH="/home/miloudi/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

command -v wmill >/dev/null && source <(wmill completions bash)

# Vite+ bin (https://viteplus.dev)
[[ -f "$HOME/.config/vite-plus/env" ]] && . "$HOME/.config/vite-plus/env"

# Dotfiles (bare repo in ~/.dotfiles)
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
