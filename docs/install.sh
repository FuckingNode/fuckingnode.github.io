#!/bin/bash

# error handling
set -Eeuo pipefail

# constants
BIN_DIR="/usr/local/bin"
EXE_NAME="fuckingnode"
EXE_PATH="$BIN_DIR/$EXE_NAME"
OLD_INSTALL_DIR="/usr/local/fuckingnode"

# what was i thinking about when making this install to a non-standard location...?
migrate_old_install() {
    SHELL_FILES=(
        "$HOME/.bashrc"
        "$HOME/.bash_profile"
        "$HOME/.profile"
        "$HOME/.zshrc"
        "$HOME/.config/fish/config.fish"
    )

    for file in "${SHELL_FILES[@]}"; do
        if [ -f "$file" ]; then
            sed -i.bak "\|$OLD_INSTALL_DIR|d" "$file" 2>/dev/null || true
        fi
    done

    if [ -d "$OLD_INSTALL_DIR" ]; then
        sudo rm -rf "$OLD_INSTALL_DIR"
    fi
}

# get where we are so it knows what to use
get_platform_arch() {
    case "$(uname -s)" in
    Darwin)
        case "$(uname -m)" in
        arm64)
            echo "macArm"
            ;;
        x86_64)
            echo "mac64"
            ;;
        *)
            echo "Unsupported macOS architecture."
            exit 1
            ;;
        esac
        ;;
    Linux)
        case "$(uname -m)" in
        armv7l)
            echo "linuxArm"
            ;;
        x86_64)
            echo "linux64"
            ;;
        *)
            echo "Unsupported Linux architecture."
            exit 1
            ;;
        esac
        ;;
    *)
        echo "Unsupported operating system, are you on TempleOS or wth?"
        exit 1
        ;;
    esac
}

ARCH=$(get_platform_arch)

remove_if_needed() {
    if [[ ${1:-} =~ ^[0-9]+$ ]]; then
        kill -9 "$1" 2>/dev/null
        rm -f $EXE_PATH
    fi
}

# get url
get_latest_release_url() {
    URL=$(curl -s "https://api.github.com/repos/FuckingNode/FuckingNode/releases/latest" |
        grep -o '"browser_download_url": "[^"]*' |
        grep "$ARCH" |
        grep -v "\.asc" |
        sed 's/"browser_download_url": "//')

    if [ -z "$URL" ]; then
        echo "No matching file found for $ARCH. This is likely our fault for not properly naming executables, please raise an issue."
        exit 1
    fi

    echo "$URL"
}

# install
install_app() {
    echo "Fetching latest release for $ARCH from GitHub..."
    local url=$(get_latest_release_url)
    echo "Fetched successfully."
    echo "Downloading..."
    sudo mkdir -p "$BIN_DIR"
    sudo curl -L "$url" -o "$EXE_PATH"
    sudo chmod +x "$EXE_PATH"
    echo "Downloaded successfully to $EXE_PATH"
}

# make shortcuts
create_shortcuts() {

    echo "Creating shortcuts for CLI..."

    # all aliases should be
    # (appName).exe <a command> [ANY ARGS PASSED]
    # so e.g. fkclean "b" = (appName) <command> "b"

    declare -A commands=(
        ["fknode"]=""
        ["fkn"]=""
        ["fkclean"]="clean"
        ["fkstart"]="kickstart"
        ["fklaunch"]="launch"
        ["fkcommit"]="commit"
        ["fkuncommit"]="uncommit"
        ["fkbuild"]="build"
        ["fkrelease"]="release"
        ["fksurrender"]="surrender"
        ["fkadd"]="add"
        ["fkrem"]="remove"
        ["fklist"]="list"
        ["fkaudit"]="audit"
        ["fkstats"]="stats"
        ["fksetup"]="setup"
        ["fkmigrate"]="migrate"
    )

    for name in "${!commands[@]}"; do
        cmd=${commands[$name]}
        script_path="$BIN_DIR/$name"

        sudo tee "$script_path" >/dev/null <<EOF
#!/usr/bin/env bash
$EXE_NAME $cmd "\$@"
EOF

        sudo chmod +x "$script_path"

        echo "Shortcut created successfully at $script_path"
    done
}

# installer itself
installer() {
    echo "Hi! We'll install FuckingNode ($ARCH edition) for you. Just a sec!"
    echo ""
    echo "Please note we'll use sudo a lot (many files to be created)."
    echo "They're all found at $BIN_DIR."
    echo "(Don't run the script itself with sudo)."
    echo ""
    echo "This script relies on you running from Bash 4 or later."
    echo ""
    sleep 1
    migrate_old_install
    remove_if_needed
    install_app
    echo "You may have seen our documentation mention shortcuts like 'fknode', 'fkn', 'fkclean'..."
    echo "We will create a bunch of shell scripts next to the main installation for these to work."
    echo ""
    create_shortcuts
    echo ""
    echo "Installed successfully!"
}

# less go
installer
