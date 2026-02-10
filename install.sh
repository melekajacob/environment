#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dst="$2"

  # Create parent directory if needed
  mkdir -p "$(dirname "$dst")"

  # Back up existing file/directory (skip if already a symlink)
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  # Remove existing symlink so ln doesn't fail
  [ -L "$dst" ] && rm "$dst"

  ln -s "$src" "$dst"
  echo "Linked $dst -> $src"
}

link "$SCRIPT_DIR/.config/nvim"   "$HOME/.config/nvim"
link "$SCRIPT_DIR/.tmux.conf"     "$HOME/.tmux.conf"
link "$SCRIPT_DIR/.wezterm.lua"   "$HOME/.wezterm.lua"
link "$SCRIPT_DIR/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
link "$SCRIPT_DIR/settings.json"    "$HOME/Library/Application Support/Code/User/settings.json"

echo "Done."
