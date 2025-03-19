# :green_apple: My macOS configs

## :grey_exclamation: Overview

This repository includes several configuration files I use, as well as a list of recommended `macOS` applications, `brew` packages, and `zed` extensions and configuration for a minimal UI look. The configuration is tailored for the [Ghostty terminal](https://github.com/ghostty-org/ghostty), using `zsh` as the default shell and is enhanced with the powerful `oh-my-zsh` framework.

![terminal](./doc/img/terminal.png)

## :wrench: Configuration files

- [.zshrc](./.zshrc): My customized `zsh` setup with aliases, functions, and plugins for enhanced productivity.
- [.opencommit](./.opencommit): OpenCommit is an open-source command-line interface (CLI) tool designed to enhance the quality of your Git commit messages by leveraging AI language models. By analyzing your code changes, OpenCommit generates concise and informative commit messages, improving the clarity and professionalism of your project’s history.
- [zed settings](./settings.json): My `zed` terminal configuration.
- `ghostty`: I am not currently using any custom configuration. It provides good defaults.

You need to install the following brew packages in order to boost the `zsh` terminal:

- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

## :dango: Recommended apps and packages

### :apple: apps

- [Ghostty](https://github.com/ghostty-org/ghostty): Ghostty is a terminal emulator that differentiates itself by being fast, feature-rich, and native. While there are many excellent terminal emulators available, they all force you to choose between speed, features, or native UIs. Ghostty provides all three
- [Raycast](https://www.raycast.com/): Raycast is a powerful, keyboard-driven productivity tool for macOS that lets users quickly perform tasks, run commands, and manage workflows through an intuitive launcher interface.
- [Meeter](https://apps.apple.com/de/app/meeter-for-zoom-teams-co/id1510445899?l=en-GB&mt=12): Meeter is a macOS app that centralizes all your calendar events and online meeting links, enabling you to quickly join meetings from various platforms like Zoom, Google Meet, or Microsoft Teams in one click.
- [Latest](https://apps.apple.com/de/app/meeter-for-zoom-teams-co/id1510445899?l=en-GB&mt=12): Software and apps update checker.
- [Orbstack](https://orbstack.dev/): OrbStack is a lightweight, high-performance virtualization and containerization platform for macOS. It simplifies running Linux VMs, Docker containers, and other workloads by providing a fast, integrated environment designed for developers. OrbStack focuses on efficiency, minimizing resource usage, and offers seamless macOS integration with features like file sharing and networking. It aims to be an alternative to solutions like Docker Desktop, with an emphasis on speed and developer-friendly workflows.
- [PastePal](https://apps.apple.com/es/app/pastepal-clipboard-manager/id1503446680): PastePal is a clipboard manager for macOS that helps users efficiently manage and organize their copied text, images, and files. It features a clean interface, quick access via a global shortcut, and advanced functionalities like searching, pinning, and syncing clips across devices. Designed for productivity, PastePal integrates seamlessly with macOS, offering privacy-focused clipboard history management and customization options for a streamlined workflow.
- [Shottr](https://shottr.cc/): Shottr is a macOS screenshot tool designed for speed and precision, offering features like pixel-perfect annotations, OCR for text extraction, scrolling screenshots, and on-the-fly image editing. It is lightweight and caters to developers, designers, and anyone needing advanced screenshot capabilities, while maintaining a user-friendly and minimalistic interface.
- [Stats](https://github.com/exelban/stats): Provides real-time statistics on your Mac’s hardware and performance. It offers insights into CPU usage, memory, disk activity, network traffic, and battery health. With a clean and simple interface, Stat allows users to monitor system performance, optimize workflows, and troubleshoot issues directly from the menu bar. It’s designed for users who want to keep track of their Mac’s vital statistics in an efficient, non-intrusive way.

## :goat: Special mention: Firefox browser

I chose Firefox for my DevOps work because it offers unique features that align perfectly with the demands of my workflow. One standout feature is its `multi-container` capability. This allows me to isolate contexts into specific containers, making it easy to manage multiple AWS accounts simultaneously. For example, I can have several `AWS` accounts open in the same browser window, each in its own tab, without cross-contamination of cookies or sessions.

Additionally, Firefox enables better personalization through support for plain `CSS` customization. This means I can tweak the browser’s appearance to match my preferences or create custom styles that improve productivity, especially when dealing with dashboards or text-heavy interfaces. These features combine to make Firefox an invaluable tool for my DevOps tasks, offering both functional flexibility and a personalized experience.

![firefox](./doc/img/firefox.png)

If you want to have a minimalistic Firefox look you can use my [userChrome.css](./userChrome.css) file. [Here](userChrome.css) you can see how to apply it. You may want to check [Keyboard shortcuts - Perform common Firefox tasks quickly](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly) since the minimal UI hides several buttons like the navigation arrows.

### :space_invader: packages

- [Ghostty](https://github.com/ghostty-org/ghostty)
- [Z](https://github.com/jethrokuan/z)
- [ccat](https://github.com/owenthereal/ccat)
- [eza](https://github.com/eza-community/eza)
- [opencommit](https://github.com/di-sukharev/opencommit)

