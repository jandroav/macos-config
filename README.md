# :green_apple: My macOS configs

Welcome to my `macOS` terminal configuration repository. This setup is optimized for performance and security by leveraging as many built-in `macOS` applications as possible.

## :grey_exclamation: Overview

This repository includes my configuration files for `oh-my-zsh`, as well as a list of my current `macOS` applications, `brew` packages, and `vscode` extensions. The configuration is tailored for the `macOS` built-in terminal emulator, using `zsh` as the default shell and is enhanced with the powerful `oh-my-zsh` framework.

## :nail_care: Theme

I am using the [Powerlevel10k - Dracula](https://draculatheme.com/powerlevel10k) theme for a sleek, modern look with informative prompts.

## :eyes: Why Stick with Built-in macOS Apps?

### :zap: Performance

By sticking to `macOS`'s built-in applications, we avoid the overhead that comes with installing and running additional third-party software. Apple’s apps are optimized for `macOS` and typically offer better performance, lower memory usage, and faster updates, especially on Apple Silicon devices.

### :lock: Security

Built-in `macOS` apps are tightly integrated with the operating system’s security features. This reduces the risk of vulnerabilities that may be introduced by third-party applications. Apple's continuous security updates further ensure that these apps are always up to date with the latest protections.

## :wrench: Included Configurations

- **Zsh Configuration (`.zshrc`)**: My customized `zsh` setup with aliases, functions, and plugins for enhanced productivity.
- **.p10k.zsh**: [Powerlevel10k - Dracula](https://draculatheme.com/powerlevel10k) theme configuration file.
- **Brew Packages**: A list of essential packages installed via Homebrew.
- **macOS Applications**: A curated list of macOS applications that I use, focused on performance and security.
- **VSCode Extensions**: A collection of my most-used Visual Studio Code extensions to streamline development.

## :white_check_mark: Getting Started

### 1. Install `oh-my-zsh`

First, you need to install `oh-my-zsh`: https://ohmyz.sh/#install

### 2. Copy the Configuration Files

```bash
git clone https://github.com/jandroav/macos-config.git
cd macOS-terminal-config
cp .zshrc ~/
cp .p10k.zsh ~/
```

### 3. Install packages and extension (Optional)

```bash
sh install_packages_extensions.sh
```

## :dango: Additional goodies

Check the following links if you want to get some additional goodies:

* [Z](https://github.com/jethrokuan/z)
* [Exa](https://the.exa.website)
* [opencommit](https://github.com/di-sukharev/opencommit)

## :floppy_disk: Applications

`ls -1 /Applications/ > apps.txt`

```
NetNewsWire.app
Shottr.app
Latest.app
WezTerm.app
DisplayLink Manager.app
zoom.us.app
TrashMe.app
The Unarchiver.app
OrbStack.app
Visual Studio Code.app
DBeaver.app
Microsoft Remote Desktop.app
Brave Browser.app
Zed.app
PastePal.app
Safari.app
Slack.app
```

## :beers: brew packages

`brew list -1 > brew_packages`

```
==> Formulae
awscli
fontconfig
gh
gnupg
gnutls
go
helm
icu4c
inframap
kubectx
kubernetes-cli
minikube
mongosh
node
openssl@3
pulumi
pygments
python-setuptools
python@3.12
spacectl
sqlite
terraform
terraform-docs
terraformer
upx
webp
xz
zoxide
zsh-autosuggestions
zsh-history-substring-search
zsh-syntax-highlighting

==> Casks
dbeaver-community
google-cloud-sdk
latest
orbstack
```

## :nut_and_bolt: vscode extensions

`code --list-extensions > vscode_extensions`

```
alefragnani.bookmarks
dracula-theme.theme-dracula
eamodio.gitlens
editorconfig.editorconfig
github.copilot
github.copilot-chat
github.vscode-github-actions
golang.go
hashicorp.terraform
ibm.output-colorizer
ms-azuretools.vscode-docker
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-vscode.makefile-tools
nicolasvuillamy.vscode-groovy-lint
redhat.java
redhat.vscode-yaml
shakram02.bash-beautify
tamasfe.even-better-toml
timonwong.shellcheck
visualstudioexptteam.intellicode-api-usage-examples
visualstudioexptteam.vscodeintellicode
vscjava.vscode-gradle
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
vscode-icons-team.vscode-icons
yzhang.markdown-all-in-one
```