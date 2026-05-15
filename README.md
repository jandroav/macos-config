# macOS config

My macOS development environment. AeroSpace tiling, SketchyBar, JankyBorders, Hyperkey, tmux. Vesper theme everywhere, JetBrainsMono Nerd Font, Ghostty terminal, Zed editor.

## Stack

| Layer | Tool |
|------|------|
| Window manager | **AeroSpace** -- pinned workspaces (1–2 external, 3–4 built-in) |
| Status bar | **SketchyBar** -- workspace pills, meeting widget (icalBuddy), CPU, memory, volume, battery, date |
| Window borders | **JankyBorders** -- Vesper orange (active) / dark gray (inactive) |
| Modifier key | **Hyperkey** -- Caps Lock → Ctrl+Alt+Shift+Cmd (tap = Esc) |
| Terminal | **Ghostty** -- Vesper, JetBrainsMono 16, native tabs disabled (use tmux) |
| Terminal mux | **tmux** -- prefix Ctrl-B, Catppuccin plugin with Vesper color overrides |
| Session manager | **sesh** -- fuzzy session switcher for tmux |
| Shell | **zsh** + **starship** + **atuin** + **zoxide** |
| Editor | **Zed** -- Vesper-ish, JetBrainsMono |
| Browser | **Zen** -- primary; Brave + Safari as backups |
| Launcher | **Raycast** -- app launching, system actions |

## Config files

| Path | Description |
|------|-------------|
| [.aerospace.toml](.aerospace.toml) | AeroSpace -- workspace pins, Hyper bindings, on-window-detected rules |
| [bordersrc](bordersrc) | JankyBorders -- Vesper orange (active) / `#404040` (inactive) |
| [sketchybar/](sketchybar/) | SketchyBar bar, items, plugins (Aerospace-aware) |
| [config](config) | Ghostty terminal -- Vesper, JetBrainsMono Nerd Font 16 |
| [.tmux.conf](.tmux.conf) | tmux -- Ctrl-B prefix, sesh integration, catppuccin w/ Vesper color overrides |
| [zed/](zed/) | Zed editor settings + keymap + tasks |
| [starship.toml](starship.toml) | Starship prompt (Nerd Font icons) |
| [.zshrc](.zshrc) | Zsh -- aliases, starship init, atuin, zoxide, plugins (NOT in this repo's sync — contains secrets) |
| [.zprofile](.zprofile) | Homebrew shellenv |
| [.gitconfig](.gitconfig) | Git -- SSH signing, rebase on pull, rerere |
| [Brewfile](Brewfile) | Homebrew taps, formulae, casks (regenerate with `brew bundle dump --force`) |
| [macos-defaults.sh](macos-defaults.sh) | macOS preferences script |
| [karabiner.json](karabiner.json) | Legacy -- replaced by Hyperkey.app; kept for reference |
| [.gitignore](.gitignore) | Repo gitignore -- macOS junk, secrets |

## Apps in /Applications

Tiling/UI: **AeroSpace**, **SketchyBar** (formula), **JankyBorders** (formula), **Hyperkey**

Daily drivers: **Ghostty**, **Zed**, **Zen**, **Slack**, **Mail** (system), **Raycast**, **MeetingBar**, **Spotify**, **Claude**, **Loom**, **Shottr**, **PastePal**, **Bitwarden**, **Docker**, **AppCleaner**, **SF Symbols**, **Wipr**, **DisplayLink Manager**, **Brave Browser**, **Safari**, **zoom.us**

## Workspace layout

| WS | Monitor | Pinned apps |
|----|---------|-------------|
| 1 | External (LG) | Zen, Ghostty |
| 2 | External (LG) | Spotify, Zed, Claude (scratch) |
| 3 | Built-in | Slack, Mail |
| 4 | Built-in | Zoom (tiled, isolated for screensharing safety) |

## Daily keybindings (Hyper = Caps Lock)

| Keys | Action |
|------|--------|
| Hyper + 1..4 | Switch workspace |
| Hyper + H/J/K/L | Focus left/down/up/right |
| Hyper + Tab | Last workspace |
| Hyper + Enter | AeroSpace fullscreen |
| Hyper + F | macOS native fullscreen |
| Hyper + T | Toggle floating ↔ tiling |
| Hyper + E | Flatten workspace tree |
| Hyper + ; | Service mode |
| Alt + Shift + 1..4 | Move focused window to workspace |
| Ctrl + Alt + H/J/K/L | Swap with window in direction |
| Alt + Shift + H/J/K/L | Resize width/height |

tmux prefix is **Ctrl-B**. See `.tmux.conf` for splits (`u`/`m`), pane nav (Ctrl-h/j/k/l no prefix), sesh integration (`j` → last session), floax floating pane (`g`).

## Setup on a fresh machine

```sh
# 1. Install Homebrew packages
brew bundle --file=Brewfile

# 2. Apply macOS defaults
bash macos-defaults.sh

# 3. Symlink configs into ~/ — adjust paths as needed
#    (this repo expects ~/.config/aerospace, ~/.config/sketchybar, ~/.config/borders,
#    ~/.config/ghostty, ~/.tmux.conf, etc.)

# 4. Install tmux plugins (one-off)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# 5. Install SF Symbols app (provides the icon font used by SketchyBar)
brew install --cask sf-symbols

# 6. Launch AeroSpace once; grant Accessibility in System Settings
open -a AeroSpace

# 7. Launch Hyperkey once; grant Accessibility
open -a Hyperkey
```

## Theme palette (Vesper)

```
background  #101010
foreground  #ffffff
muted       #a0a0a0
selection   #3f3f3f
accent      #ffc799   (orange — primary)
mint        #99ffe4   (secondary accent)
red         #ff8080   (danger)
```

Used across: AeroSpace borders, SketchyBar items, tmux status, Ghostty, Zed.
