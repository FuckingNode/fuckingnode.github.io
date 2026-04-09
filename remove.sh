#!/bin/bash

set -e

INSTALL_DIR="/usr/local/fuckingnode"

remove_the_thing() {
    echo "Removing install files..."

    if [ -d "$INSTALL_DIR" ]; then
        if sudo rm -rf "$INSTALL_DIR" 2>/dev/null; then
            echo "Removed $INSTALL_DIR entirely"
        else
            echo "Failed to remove $INSTALl_DIR."
        fi
    fi
}

clean_path_from_file() {
    local file="$1"

    [ ! -f "$file" ] && return

    if grep -q "$INSTALL_DIR" "$file"; then
        cp "$file" "$file.bak_fuckingnode_$(date +%Y%m%d%H%M%S)"
        sed -i "\#$INSTALL_DIR#d" "$file"
        echo "Lines containing $INSTALL_DIR gone from $file (a backup was made just in case, .bak_fuckingnode_*)."
    fi
}

clean_path_config() {
    echo "Clearing PATH..."

    FILES_BASH=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")
    FILES_ZSH=("$HOME/.zshrc")
    FISH_CONFIG="$HOME/.config/fish/config.fish"

    for f in "${FILES_BASH[@]}"; do
        clean_path_from_file "$f"
    done

    for f in "${FILES_ZSH[@]}"; do
        clean_path_from_file "$f"
    done

    clean_path_from_file "$FISH_CONFIG"
}

main() {
    echo "FuckingNode uninstall"
    echo "So sad to see you leave :("
    echo "This'll remove binaries, shortcuts, and PATH entries related to FuckingNode."
    echo ""

    read -r -p "Proceed? [y/N]: " ans
    case "$ans" in
        y|Y|yes|YES)
            ;;
        *)
            echo "Aborted. Thanks for staying!"
            exit 0
            ;;
    esac

    remove_the_thing
    clean_path_config

    echo ""
    echo "Uninstalled successfully."
    echo "If you did this because you were unsatisfied with FuckingNode, please create an issue at https://github.com/FuckingNode/FuckingNode/issues/new telling us how we could improve."
    echo "Thank you anyways, cya!"
}

main "$@"
