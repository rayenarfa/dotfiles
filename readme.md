# 🏠 Rayen's Dotfiles

![Arch Linux Logo](arch-linux-logo.png)

A clean, high-performance, and minimal setup tailored for **Arch Linux / CachyOS** utilizing the **i3 Window Manager**, **Kitty**, and **Rofi**. This repository is configured to make moving between fresh Linux installations seamless, getting you "back home" in minutes.

---

## 🚀 Setup Highlights

*   **OS:** Arch Linux / CachyOS (optimized kernels & repos)
*   **Window Manager:** `i3-wm` (tiling manager)
*   **Terminal:** `kitty` (GPU-accelerated, highly customizable)
*   **Application Launcher:** `rofi` (modern dmenu replacement)
*   **File Manager:** `thunar` (lightweight file manager)
*   **Wallpaper Manager:** `feh` (with custom rotation & selection scripts)
*   **Dotfile Linker:** GNU `stow` (symlink farm manager)
*   **Code Editors:** `zed`, `cursor-bin`, `code` (VSCode)

---

## 💿 Archinstall Menu Guide (Fresh Install)

To get a clean, optimized foundation for this setup using the official `archinstall` script, configure the menu options as follows:

| archinstall Menu Item | Recommended Choice | Rationale |
| :--- | :--- | :--- |
| **Disk configuration** | **Use a best-effort default layout** (or manual partition if dual-booting) | Choose **ext4** (standard) or **btrfs** (supports snapshots). |
| **Bootloader** | **systemd-boot** (or **GRUB**) | systemd-boot is extremely lightweight and fast. |
| **User account** | **Add a user** (e.g., `rayen`) and toggle **Superuser (sudo) to Yes** | **CRITICAL:** Do not forget to make your user a superuser. |
| **Profile** | **Type: Minimal** | **CRITICAL:** Do NOT install any Desktop/Window Manager from here. We will deploy i3 cleanly via dotfiles. |
| **Audio** | **Pipewire** | Modern, low-latency audio server. Essential for Bluetooth/audio routing. |
| **Additional packages** | Add: `git`, `networkmanager`, `bluez`, `bluez-utils` | Ensures you have internet, Bluetooth, and git on your first boot. |
| **Network configuration**| **Use NetworkManager** | Essential for laptop WiFi/Ethernet management. |
| **Optional repositories** | Enable **multilib** | Required to run 32-bit applications (Steam, Wine, Discord). |
| **Graphics driver** | **Nvidia (proprietary)** | **CRITICAL:** Installs proprietary NVIDIA drivers (`nvidia`, `nvidia-utils`, `lib32-nvidia-utils`). |

### 🔋 Hybrid Laptop Graphics (NVIDIA Optimus)
Since you are on a laptop with hybrid graphics (Intel/AMD + NVIDIA):
1.  By default, the system will run on your integrated GPU (Intel or AMD) to maximize battery life.
2.  Your `packages.txt` installs `nvidia-prime`. To launch heavy applications, games, or IDEs on the dedicated NVIDIA GPU, simply run them with `prime-run`:
    ```bash
    prime-run steam
    prime-run zed
    ```

---

## 📦 Restoring Your System (Getting Back Home)


Follow these steps to restore your entire desktop environment and configuration on a fresh CachyOS or Arch Linux installation.

### 1. Prerequisites & Preparation

Make sure your system is updated and you have Git installed:
```bash
sudo pacman -Syu
sudo pacman -S git
```

Install `yay` (AUR helper) if not already present:
```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd .. && rm -rf yay
```

### 2. Clone the Dotfiles Repo

Clone this repository directly into your home folder:
```bash
git clone https://github.com/rayenarfa/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Restore Your Packages

Install all the packages defined in your configuration backup. This includes base system packages, GUI software, tools, and libraries.

```bash
# Install pacman packages
sudo pacman -S --needed - < packages.txt

# Install AUR packages (using yay)
yay -S --needed - < aur-packages.txt
```

### 4. Deploy Configurations with GNU Stow

Instead of manually copying files and risking broken configs, this setup uses **GNU Stow** to manage symlinks. Running stow creates clean symbolic links from the repository to your target home directories.

```bash
cd ~/dotfiles

# Stow configurations (links dotfiles/config/i3 -> ~/.config/i3)
stow config

# Stow custom bin folder (links dotfiles/bin/.local/bin -> ~/.local/bin)
stow bin
```

*Note: Make sure to delete or rename any existing `~/.config/i3/config` file before stowing, otherwise Stow will throw a conflict error.*

### 5. Setup Wallpapers Directory

The custom wallpaper scripts expect your wallpapers to be located in `~/Pictures/wallpapers/`.
```bash
mkdir -p ~/Pictures/wallpapers
```
Simply place your favorite images there, and the scripts will manage them.

### 6. Enable Services & System Tweaks

Run the included services script to enable system services (Bluetooth, UFW firewall, network management tools, ananicy performance enhancements) and apply swappiness optimizations:

```bash
chmod +x ~/dotfiles/scripts/*.sh
~/dotfiles/scripts/enable-services.sh
```

---

## 🛠️ Custom Scripts Reference

The `scripts/` and `bin/` directories contain handy utilities to manage system resources and visuals.

| Script Location | Description |
| :--- | :--- |
| [`scripts/enable-services.sh`](file:///home/rayen/dotfiles/scripts/enable-services.sh) | Enables essential system services (Bluetooth, firewall, etc.) and sets the power profile to `performance`. |
| [`scripts/disable-services.sh`](file:///home/rayen/dotfiles/scripts/disable-services.sh) | Disables system-intensive services, sets swappiness to `10`, and sets the power profile to `power-saver` (great for laptops). |
| [`scripts/enable-turbo.sh`](file:///home/rayen/dotfiles/scripts/enable-turbo.sh) | Turns CPU Intel/AMD Turbo Boost **ON** for maximum performance. |
| [`scripts/disable-turbo.sh`](file:///home/rayen/dotfiles/scripts/disable-turbo.sh) | Turns CPU Turbo Boost **OFF** to cap frequency, reducing heat and extending battery life. |
| [`bin/.local/bin/wallpaper`](file:///home/rayen/dotfiles/bin/.local/bin/wallpaper) | Cycles to the next wallpaper in `~/Pictures/wallpapers/` and symlinks it to `current.jpg`. |
| [`bin/.local/bin/wallpaper-select`](file:///home/rayen/dotfiles/bin/.local/bin/wallpaper-select) | Opens a visual list in `rofi` allowing you to search and select a specific wallpaper. |

---

## ⌨️ i3 Keybindings Quick Cheat Sheet

Here are the primary keybindings defined in your [`i3 config`](file:///home/rayen/dotfiles/config/i3/config):

*   `Mod` key is mapped to **Windows Key / Super Key** (`Mod4`).

| Keybinding | Action |
| :--- | :--- |
| `Mod + Return` | Launch **Kitty** Terminal |
| `Mod + d` | Open **Rofi** Application Launcher |
| `Mod + b` | Open **Firefox** |
| `Mod + Shift + f` | Open **Thunar** File Explorer |
| `Mod + Shift + w` | Cycle Wallpaper |
| `Mod + Shift + s` | Select Wallpaper via Rofi |
| `Mod + Shift + q` | Close Focused Window |
| `Mod + Shift + r` | Restart i3 In-Place (reloads config without losing session) |
| `Mod + Shift + e` | Exit i3 Window Manager (Log out) |
| `Mod + r` | Enter Window Resize Mode (Arrow keys or `hjkl` to resize; `Esc`/`Enter` to exit) |
| `Mod + Arrow Keys` or `j/k/l/;` | Focus neighboring window |
| `Mod + Shift + Arrows` or `j/k/l/;` | Move focused window |
| `Mod + Space` | Toggle tiling/floating mode |

---

## 🔌 Hardware, Drivers & Storage Setup

Getting your physical hardware optimized and working correctly right after a fresh Arch Linux / CachyOS install.

### 1. NVIDIA GPU Max Performance Tweaks
To extract maximum performance from your NVIDIA card, prevent screen tearing, and set power modes:

*   **DRM Kernel Modesetting (Prevents Screen Tearing & Stuttering):**
    Add the `nvidia-drm.modeset=1` parameter to your kernel command line.
    *   If using **GRUB**: Edit `/etc/default/grub` and append `nvidia-drm.modeset=1` to `GRUB_CMDLINE_LINUX_DEFAULT`, then run:
        ```bash
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        ```
    *   If using **systemd-boot**: Edit `/loader/entries/*.conf` and add `nvidia-drm.modeset=1` to the options line.
*   **Force Maximum Performance Power Mode:**
    By default, NVIDIA uses adaptive power clocking. To force the GPU into maximum performance mode:
    ```bash
    # Set GPU PowerMizer Mode to "Prefer Maximum Performance"
    nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1"
    ```
    *(You can add this line to your `~/.xprofile` or i3 config `exec --no-startup-id nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1"` so it runs on startup).*

### 2. Audio, WiFi, and Bluetooth Setup
To make sure network, sound, and Bluetooth work correctly out of the box under `i3-wm`:

*   **WiFi Network Management:**
    Your setup uses NetworkManager. Enable and start it:
    ```bash
    sudo systemctl enable --now NetworkManager.service
    ```
    *Note: `nm-applet` is launched automatically in your i3 config to give you a tray icon.*
*   **Audio (PipeWire):**
    Ensure all PipeWire and user sound services are enabled so audio devices swap and route properly:
    ```bash
    systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service
    ```
*   **Bluetooth:**
    Enable the bluetooth service system-wide:
    ```bash
    sudo systemctl enable --now bluetooth.service
    ```

### 3. Permanently Mounting Storage Drives (HDD/SSD)
To ensure your additional drives are automatically mounted securely at boot without slowing down system startup:

1.  **Create your mount directories:**
    ```bash
    sudo mkdir -p /data
    sudo mkdir -p /mnt/HDD
    ```
2.  **Edit `/etc/fstab`:**
    ```bash
    sudo nano /etc/fstab
    ```
3.  **Add your drive mapping lines:**
    Append the following configuration using the block UUIDs (which uniquely identify the drives regardless of which SATA port they are plugged into):
    ```fstab
    # ext4 storage partition
    UUID=570c3f49-a037-460f-bca6-db53e30dabe7  /data  ext4  defaults,noatime  0  2

    # NTFS external or secondary HDD (safe automounting settings)
    UUID=540C46800C465D5C /mnt/HDD ntfs-3g defaults,noatime,nofail,x-systemd.automount,x-systemd.device-timeout=10 0 0
    ```
    *   `noatime`: Disables writing file access times, reducing drive wear and improving speeds.
    *   `nofail`: Allows the system to boot smoothly even if the HDD is unplugged or fails to mount.
    *   `x-systemd.automount`: Delay-mounts the partition until it is first accessed, accelerating boot time.
    *   `x-systemd.device-timeout=10`: Stops waiting for the disk after 10 seconds if it is missing.

---

## 💾 General Linux Software Installation Guide


When transitioning to a fresh Linux install, you will frequently download apps that aren't available in standard repositories. Here is a guide on how to install and manage them:

### 1. AppImages

AppImages are portable, single-file executables that run on almost any Linux distribution without installation or root access.

#### How to run an AppImage manually:
1.  Download the `.AppImage` file.
2.  Make it executable:
    ```bash
    chmod +x ApplicationName.AppImage
    ```
3.  Double-click it in your file manager or run it from the terminal:
    ```bash
    ./ApplicationName.AppImage
    ```

#### Desktop Integration (Adding to App Menu):
To make it behave like a native application with an icon in your Rofi/desktop launcher, you can manually create a desktop entry:
1.  Move the AppImage to a permanent folder:
    ```bash
    mkdir -p ~/Applications
    mv ApplicationName.AppImage ~/Applications/
    ```
2.  Create a desktop file in `~/.local/share/applications/`:
    ```bash
    nano ~/.local/share/applications/application-name.desktop
    ```
3.  Add the following structure:
    ```ini
    [Desktop Entry]
    Type=Application
    Name=App Name
    Exec=/home/YOUR_USERNAME/Applications/ApplicationName.AppImage
    Icon=/path/to/icon.png
    Categories=Utility;
    Terminal=false
    ```
4.  Save and exit. The app will immediately show up in your Rofi application list!

> [!TIP]
> To automate this process, install `AppImageLauncher`. It automatically intercepts AppImages when you double-click them, moves them to a central location, and sets up desktop menu shortcuts for you.

---

### 2. Tarballs and Archives (`.tar.gz`, `.tar.xz`, `.zip`)

Many software developers distribute binary packages or raw source code inside tarballs or compressed files instead of system packages.

#### How to extract:
```bash
# For .tar.gz files
tar -zxvf package.tar.gz

# For .tar.xz files
tar -xvf package.tar.xz

# For .zip files
unzip package.zip
```

#### Where to place the extracted files:
*   **User-only installation (Recommended for dotfiles setups):**
    Place it in `~/.local/share/` or `~/Apps/` and symlink the binary into `~/.local/bin/` (which is already in your `$PATH` in this dotfiles setup!).
    ```bash
    mv extracted-folder ~/.local/share/appname
    ln -sf ~/.local/share/appname/binary-file ~/.local/bin/appname
    ```
*   **System-wide installation (Requires root):**
    Place it in `/opt/` (reserved for manually installed software) and symlink to `/usr/local/bin/`.
    ```bash
    sudo mv extracted-folder /opt/appname
    sudo ln -sf /opt/appname/binary-file /usr/local/bin/appname
    ```

#### Creating desktop menus:
Just like AppImages, create a `.desktop` file under `~/.local/share/applications/` and point the `Exec` field to the symlinked binary (e.g., `Exec=appname`).

---

### 3. Flatpaks

Flatpak is a sandboxed package manager that operates independently of your host system dependencies.

#### Basic Usage:
1.  **Enable Flathub repository (if not enabled):**
    ```bash
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    ```
2.  **Install an app:**
    ```bash
    flatpak install flathub org.videolan.VLC
    ```
3.  **Run a Flatpak:**
    ```bash
    flatpak run org.videolan.VLC
    ```
4.  **Manage Permissions (Highly Recommended):**
    Install **Flatseal** via Flatpak to easily manage application directories, network, and audio/graphics card permissions through a graphical user interface:
    ```bash
    flatpak install flathub com.github.tchx84.Flatseal
    ```

---

## 🐳 Docker & Immich Self-Hosting Guide

This repository includes support for hosting **Immich** (self-hosted Google Photos alternative) via Docker Compose.

### 1. Enable Docker on System Boot
On a fresh Linux installation, the Docker daemon is disabled by default. To start and enable it on every boot:
```bash
sudo systemctl enable --now docker.service
```

To run docker commands without typing `sudo` every time:
```bash
sudo usermod -aG docker $USER
# Log out and log back in (or run 'newgrp docker') to apply changes
```

### 2. Restoring the `/data` Partition (No Data Loss)
Your games, projects, and the Immich configuration stack are stored on a dedicated `ext4` partition. 
To mount this partition back to `/data` without losing any of your existing files, ensure your `/etc/fstab` contains the following entry:
```fstab
UUID=570c3f49-a037-460f-bca6-db53e30dabe7  /data  ext4  defaults,noatime  0  2
```
*   Mounting an existing partition preserves all internal directories (e.g., `/data/immich-stack/`, `/data/steam/`, etc.) exactly as they were.

### 3. Immich Architecture (Performance vs. Storage)
For the optimal Immich hosting experience, storage should be divided based on performance requirements:

*   **Database (Postgres) ➡️ SSD (Fast Storage):**
    The database handles metadata indexing, search queries, and face recognition data. It requires high random read/write performance.
    *   **Keep it on your SSD** (e.g., `/data/immich-stack/postgres` if `/data` is on SSD, or under `/var/lib/postgresql/data` on your root `/` drive).
    *   *Do NOT move the database folder to a mechanical HDD*, as it will bottleneck image scrolling and search.
*   **Media Library (Photos/Videos) ➡️ HDD (High Capacity):**
    Actual photos and video files are large and read sequentially, which mechanical HDDs handle easily.
    *   **Store it on your HDD** (e.g., `/mnt/HDD/immich-library`).
    *   Configure this in `/data/immich-stack/.env` by setting:
        ```env
        UPLOAD_LOCATION=/mnt/HDD/immich-library
        ```

### 4. Running the Immich Stack
Once your drives are mounted and the Docker service is enabled, navigate to the stack directory and launch the containers:
```bash
cd /data/immich-stack
docker compose up -d
```
You can access your local Immich instance at `http://localhost:2283`.

---

## 🔄 Updating Your Repository

When you tweak your local configs, push the updates to GitHub with:
```bash
cd ~/dotfiles
git add .
git commit -m "Update configurations: $(date +'%Y-%m-%d %H:%M')"
git push
```
