# macOS config

My macOS development environment. Ghostty terminal, zsh shell, starship prompt, zoxide navigation, Gruvbox Dark theme.

## Config files

| File | Description |
|------|-------------|
| [.zshrc](.zshrc) | Shell config -- aliases, starship, zoxide, zsh plugins |
| [.zprofile](.zprofile) | Homebrew shellenv |
| [config](config) | Ghostty terminal -- Gruvbox Dark, FiraCode 16px, tabs |
| [karabiner.json](karabiner.json) | Caps Lock -> hyper key, double-tap RShift -> caps, grave/backslash swap (ISO) |
| [zed/](zed/) | Zed editor -- settings, keymap, tasks (Gruvbox Dark, OpenTofu LSP, CodeSnap) |
| [starship.toml](starship.toml) | Starship prompt with Nerd Font symbols |
| [.gitconfig](.gitconfig) | Git -- SSH signing, rebase on pull, rerere, prune on fetch |
| [Brewfile](Brewfile) | Homebrew taps, formulae, casks |
| [macos-defaults.sh](macos-defaults.sh) | macOS preferences script (dock, finder, trackpad, dark mode) |
| [.gitignore](.gitignore) | Repo gitignore -- macOS files, secrets |

## Apps

Installed in `/Applications/`:

- **Ghostty** -- terminal
- **Zed** -- primary editor
- **Zen** -- primary browser
- **Docker** -- containers
- **DBeaver** -- database client
- **Raycast** -- launcher
- **Shottr** -- screenshots
- **PastePal** -- clipboard manager
- **Latest** -- app update checker
- **Spotify** -- music
- **Things3** -- task manager
- **Karabiner-Elements** -- keyboard customization
- **AppCleaner** -- app uninstaller
- **Screen Studio** -- screen recording
- **Cyberduck** -- FTP/S3 client
- **GPG Keychain** -- GPG key management
- **zoom.us** -- video calls
- **Firefox** -- secondary browser

## Setup

```sh
# install homebrew packages
brew bundle --file=Brewfile

# apply macOS defaults
bash macos-defaults.sh
```
