# Dotfiles for Arch Linux

![Arch Linux Logo](arch-linux-logo.png)

This repository contains my personal configuration files for Arch Linux, focusing on a lightweight and customizable setup with the i3 window manager.

## 📋 Prerequisites

Before using these dotfiles, ensure you have the following installed:

- **Arch Linux**: Base installation
- **i3-gaps**: Tiling window manager
- **polybar**: Status bar
- **feh**: Wallpaper manager
- **picom**: Compositor
- **rofi**: Application launcher
- **alacritty**: Terminal emulator
- **neovim**: Text editor

## 📦 Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/rayenarfa/dotfiles.git
    cd dotfiles
    ```

2.  **Backup existing dotfiles** (optional but recommended):
    ```bash
    mkdir -p backup
    cp ~/.config/i3/config backup/
    cp ~/.config/polybar/config backup/
    # ... copy other config files
    ```

3.  **Install the dotfiles**:
    ```bash
    ./install.sh
    ```

    The `install.sh` script will:
    - Copy configuration files to `~/.config/`
    - Create necessary directories
    - Set up symbolic links for custom scripts

## 📂 File Structure

```
dotfiles/
├── bin/                 # Custom scripts
│   ├── wallpaper        # Wallpaper management script
│   └── ...
├── .config/
│   ├── i3/              # i3 window manager configuration
│   │   └── config       # i3 config
│   ├── polybar/         # Polybar status bar
│   │   ├── config       # Polybar config
│   │   └── launch.sh    # Polybar launch script
│   ├── picom/           # Picom compositor
│   │   └── picom.conf   # Picom config
│   ├── rofi/            # Rofi application launcher
│   │   ├── config       # Rofi config
│   │   └── themes/      # Rofi themes
│   ├── alacritty/       # Alacritty terminal
│   │   └── alacritty.yml
│   └── neovim/          # Neovim editor
│       ├── init.lua     # Neovim config
│       └── lua/         # Plugin configurations
├── install.sh           # Installation script
├── README.md            # This file
└──LICENSE              # License information
```

## 🛠️ Configuration

### i3 Window Manager

The main configuration file is `~/.config/i3/config`. You can customize keybindings, gaps, and window rules here.

**Common Keybindings**:

- `Mod+Enter`: Launch terminal
- `Mod+d`: Open Rofi launcher
- `Mod+Shift+e`: Quit i3
- `Mod+Shift+r`: Reload i3
- `Mod+Arrow Keys`: Move between windows
- `Mod+Shift+Arrow Keys`: Move windows
- `Mod+Shift+Space`: Toggle floating mode

### Polybar

Edit `~/.config/polybar/config` to customize your status bar. The `launch.sh` script will start Polybar with the configured modules.

### Rofi

Custom Rofi themes are located in `~/.config/rofi/themes/`. You can switch themes by modifying `~/.config/rofi/config`.

## 🎨 Visuals

### Wallpapers

Place your wallpaper images in `~/Pictures/wallpapers/`. The `bin/wallpaper` script will automatically cycle through them.

### GTK Theme

Install GTK themes (e.g., from [GNOME Look](https://www.gnome-look.org/)) and set them using `lxappearance`:

```bash
sudo pacman -S lxappearance
lxappearance
```

## 📚 Additional Configuration

### Neovim

This setup uses a minimal Neovim configuration with:

- Lua-based plugin management
- Essential plugins for coding
- Custom keybindings

### Fonts

Install Nerd Fonts for proper icon display in Polybar:

```bash
sudo pacman -S ttf-nerd
```

## 📝 Customization

Feel free to modify these files to match your preferences. Some common customizations include:

- **Keybindings**: Edit `~/.config/i3/config`
- **Terminal**: Edit `~/.config/alacritty/alacritty.yml`
- **Theme**: Use `lxappearance` or edit GTK config files
- **Shell**: Configure your preferred shell (zsh, fish, etc.)

## 🔄 Updating Dotfiles

If you make changes to your local dotfiles, you can update the repository with:

```bash
git add .
git commit -m "Update configurations"
git push
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

