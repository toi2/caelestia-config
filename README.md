# caelestia-config

Personal configuration profiles, window manager integrations, and shell environments for Caelestia Shell.

---

## Overview

This repository contains my personal dotfiles and setup configurations. For CachyOS users, it includes an automated installation script that cleanses system identity metadata back to Arch Linux, preserves the high-performance CachyOS kernel, and installs the custom **Midnight** fork of Caelestia Shell alongside Hyprland.

---

## Prerequisites

Before running the installation setup, ensure your system meets the following requirements:

* **Operating System:** Fresh installation of CachyOS (recommended) or Arch Linux.
* **Network:** Active internet connection to pull AUR packages and git repositories.
* **Base Packages:** `curl`, `git`, `bash`, and `sudo` access.

---

## Quickstart & Installation

> [!IMPORTANT]
> **CachyOS Users Only:** The automated installation script (`setup.sh`) is designed specifically for **CachyOS**. It strips CachyOS OS-identity files back to stock Arch Linux branding while keeping your CachyOS performance kernel intact. Do not run this script on standard Arch Linux or other derivatives.

### Option A: One-Liner (Automated for CachyOS)

Open a terminal on your fresh CachyOS installation and run:

```bash
curl -sSL https://raw.githubusercontent.com/toi2/caelestia-config/main/setup.sh | bash
```

### Option B: Manual Execution

If you want to clone the repository first and inspect the setup script locally:

```bash
git clone https://github.com/toi2/caelestia-config.git ~/caelestia-setup
cd ~/caelestia-setup
chmod +x setup.sh
./setup.sh
```

---

## What `setup.sh` Does

1. **ToiletPaper Execution:** Runs the ToiletPaper utility to restore the vanilla Arch Linux OS identity (`/etc/os-release`), reset Hyprland defaults, and purge stock Noctalia setups without removing the CachyOS kernel.
2. **Package Manager Setup:** Installs `paru` as the primary AUR helper.
3. **Core Compositor Installation:** Installs `hyprland` directly via `pacman`.
4. **Shell & Utility Dependencies:** Installs `quickshell-git` and `midnight-cli-git` from the AUR.
5. **Midnight Fork Deployment:** Installs `midnight-shell-git` (a custom fork of Caelestia Shell).
6. **Config Deployment:** Clones this repository directly into `~/.config/caelestia`.

---

## How to 'UPDATE' 

Simply run ```paru -Syyuu``` to update the whole system normally.

---

## File Structure

* `config.json` & `shell.json`: Main layout, module configuration, and behavioral settings for Caelestia Shell.
* `user-config.fish`: Custom aliases, functions, and environment variables for the Fish shell.
* `hypr-user.lua` & `hypr-vars.lua`: Lua scripts bridging desktop shell environment variables with Hyprland.
* `monitors/`: Saved display layouts, refresh rates, and multi-monitor positioning profiles.
