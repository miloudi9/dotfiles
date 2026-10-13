# dotfiles

Hyprland on Arch. Configs for bash, tmux, kitty, nvim, yazi, waybar, fuzzel,
plus GTK/Qt theming (Tokyonight-Dark, Papirus-Dark) and fontconfig.

Stored as a bare git repo in `~/.dotfiles`, work tree is `$HOME`.

## Packages

```bash
sudo pacman -S --needed \
  hyprland uwsm hypridle hyprsunset hyprpolkitagent xdg-desktop-portal-hyprland qt6-wayland \
  waybar fuzzel mako kitty tmux neovim yazi \
  wl-clipboard cliphist wl-clip-persist grim slurp brightnessctl playerctl libqalculate \
  networkmanager network-manager-applet pavucontrol \
  git bash-completion fzf ripgrep fd bat eza jq tree-sitter-cli \
  qt6ct papirus-icon-theme \
  noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-nerd-fonts-symbols-mono

# AUR (GTK theme)
yay -S tokyonight-gtk-theme-git
```

## Install

```bash
git clone --bare https://github.com/miloudi9/dotfiles.git ~/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot config status.showUntrackedFiles no

# back up any existing files that would be overwritten, then check out
dot checkout 2>&1 | grep -E '^\s+\.' | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname {}) && mv ~/{} ~/.dotfiles-backup/{}'
dot checkout
```

The `dot` alias is already in `.bashrc` after checkout.

Private env vars go in `~/.bashrc.secrets` (not tracked, loaded if present).

## Usage

```bash
dot status
dot add ~/.config/foo
dot commit -m "..."
dot push
```
