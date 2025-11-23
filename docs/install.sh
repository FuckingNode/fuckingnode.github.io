#!/bin/bash

# error handling
set -e
# set -u

# constants
INSTALL_DIR="/usr/local/fuckingnode"
EXE_PATH="/usr/local/fuckingnode/fuckingnode"

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
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        kill -9 $1 2>/dev/null
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
    sudo mkdir -p "$INSTALL_DIR"
    sudo curl -L "$url" -o "$EXE_PATH"
    sudo chmod +x $EXE_PATH
    echo "Downloaded successfully to $EXE_PATH"
}

# make shortcuts
create_shortcuts() {

    echo "Creating shortcuts for CLI..."

    if [[ -z "$INSTALL_DIR" || ! -d "$INSTALL_DIR" ]]; then
        echo "Error: Install directory '$INSTALL_DIR' does not exist or is not defined."
        exit 1
    fi

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
        script_path="$INSTALL_DIR/$name"

        echo "#!/bin/bash" | sudo tee "$script_path" >/dev/null
        echo "\"\$(dirname \"\$0\")/fuckingnode\" $cmd \"\$@\"" | sudo tee -a "$script_path" >/dev/null

        sudo chmod +x "$script_path"

        echo "Shortcut created successfully at $script_path"
    done
}

# add app to path
add_app_to_path() {
    echo "Adding shorthand $INSTALL_DIR to PATH..."

    if [ -z "$INSTALL_DIR" ]; then
        echo "Install directory is undefined or empty."
        exit 1
    fi

    # detect current shell name (bash, zsh, fish, etc.)
    local shell_name
    shell_name="$(basename "${SHELL:-}")"

    echo "Detected shell: ${shell_name:-unknown}"

    # default bash-like files
    local FILES_BASH=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")
    # zsh config
    local FILES_ZSH=("$HOME/.zshrc")
    # fish config
    local FISH_CONFIG="$HOME/.config/fish/config.fish"

    local modified=0

    case "$shell_name" in
        bash|"")
            echo "Configuring PATH for Bash-compatible shells..."
            for file in "${FILES_BASH[@]}"; do
                if [ -f "$file" ]; then
                    if ! grep -q "$INSTALL_DIR" "$file"; then
                        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>"$file"
                        echo "Added $INSTALL_DIR to PATH in $file"
                        modified=1
                    else
                        echo "$INSTALL_DIR is already in $file."
                    fi
                fi
            done
            ;;

        zsh)
            echo "Configuring PATH for zsh..."
            for file in "${FILES_ZSH[@]}"; do
                # create file if it doesn't exist
                if [ ! -f "$file" ]; then
                    touch "$file"
                fi
                if ! grep -q "$INSTALL_DIR" "$file"; then
                    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>"$file"
                    echo "Added $INSTALL_DIR to PATH in $file"
                    modified=1
                else
                    echo "$INSTALL_DIR is already in $file."
                fi
            done
            ;;

        fish)
            echo "Configuring PATH for fish..."
            mkdir -p "$(dirname "$FISH_CONFIG")"
            if [ ! -f "$FISH_CONFIG" ]; then
                touch "$FISH_CONFIG"
            fi
            if ! grep -q "$INSTALL_DIR" "$FISH_CONFIG" 2>/dev/null; then
                # fish uses fish_add_path to manage PATH cleanly
                echo "fish_add_path \"$INSTALL_DIR\" 2>/dev/null; or set -gx PATH \"$INSTALL_DIR\" \$PATH" >>"$FISH_CONFIG"
                echo "Added $INSTALL_DIR to PATH in $FISH_CONFIG"
                modified=1
            else
                echo "$INSTALL_DIR is already in $FISH_CONFIG."
            fi
            ;;

        *)
            echo "Unknown shell '$shell_name'. Falling back to Bash-style config files."
            for file in "${FILES_BASH[@]}"; do
                if [ -f "$file" ]; then
                    if ! grep -q "$INSTALL_DIR" "$file"; then
                        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >>"$file"
                        echo "Added $INSTALL_DIR to PATH in $file"
                        modified=1
                    fi
                fi
            done
            ;;
    esac

    if (( modified == 1 )); then
        echo "PATH config updated. Please restart your terminal or re-source your shell config (e.g., 'source ~/.bashrc', 'source ~/.zshrc', or 'exec fish')."
    else
        echo "No PATH was modified."
    fi
}

# installer itself
installer() {
    echo "Hi! We'll install FuckingNode ($ARCH edition) for you. Just a sec!"
    echo ""
    echo "Please note we'll use sudo a lot (many files to be created)."
    echo "They're all found at $INSTALL_DIR."
    echo "(Don't run the script itself with sudo)."
    echo ""
    echo "This script relies on you running from Bash 4 or later."
    echo ""
    remove_if_needed
    install_app
    add_app_to_path
    echo "You may have seen our documentation mention shortcuts like 'fknode', 'fkn', 'fkclean'..."
    echo "We will create a bunch of shell scripts next to the main installation for these to work."
    echo ""
    create_shortcuts
    echo ""
    echo "Installed successfully! Restart your terminal for it to work."
}

# less go
installer
