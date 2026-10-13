#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# uv
export PATH="/home/miloudi/.local/bin:$PATH"

export EDITOR=nvim

# Vite+ bin (https://viteplus.dev)
[[ -f "$HOME/.config/vite-plus/env" ]] && . "$HOME/.config/vite-plus/env"
