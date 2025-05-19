#!/bin/sh

# wallpaper-selector.sh - A script to select and set wallpapers using rofi and swww
#
# Dependencies:
# - rofi
# - swww
# - find

# Configuration
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
TRANSITION="fade"      # swww transition type
TRANSITION_STEP=2      # swww transition step (lower is smoother)
TRANSITION_DURATION=3  # swww transition duration in seconds

# Check if the wallpaper directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Error: Wallpaper directory not found: $WALLPAPER_DIR"
    echo "Please create it or modify the script to use a different directory."
    exit 1
fi

# Check if swww is installed
if ! command -v swww &> /dev/null; then
    echo "Error: swww is not installed. Please install it first."
    exit 1
fi

# Check if rofi is installed
if ! command -v rofi &> /dev/null; then
    echo "Error: rofi is not installed. Please install it first."
    exit 1
fi

# Check if swww daemon is running, if not start it
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "Starting swww daemon..."
    swww init
    sleep 1
fi

# Find all images in the wallpaper directory
find_wallpapers() {
    find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \)
}

# Create a temporary file for the wallpaper paths
WALLPAPER_LIST=$(mktemp)
find_wallpapers > "$WALLPAPER_LIST"

# Count the number of wallpapers found
WALLPAPER_COUNT=$(wc -l < "$WALLPAPER_LIST")

if [[ $WALLPAPER_COUNT -eq 0 ]]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    echo "Please add some image files (jpg, jpeg, png, gif, webp) to this directory."
    rm "$WALLPAPER_LIST"
    exit 1
fi

echo "Found $WALLPAPER_COUNT wallpapers"

# Create a temporary file for the rofi menu
ROFI_MENU=$(mktemp)

# Format data for rofi with icons
while IFS= read -r wallpaper_path; do
    filename=$(basename "$wallpaper_path")
    echo -e "$filename\0icon\0$wallpaper_path" >> "$ROFI_MENU"
done < "$WALLPAPER_LIST"

# Use rofi to display the list of wallpapers with image previews
selected=$(rofi -dmenu -i \
    -p "Select wallpaper:" \
    -theme-str 'window {width: 80%; height: 70%;}' \
    -theme-str 'listview {columns: 3; lines: 3;}' \
    -theme-str 'element {orientation: vertical; padding: 2% 0%;}' \
    -theme-str 'element-icon {size: 12ch;}' \
    -show-icons \
    < "$ROFI_MENU")

# Clean up temporary files
rm "$WALLPAPER_LIST" "$ROFI_MENU"

# Exit if no wallpaper was selected
if [[ -z "$selected" ]]; then
    echo "No wallpaper selected. Exiting."
    exit 0
fi

# Find the full path of the selected wallpaper
CHOSEN_WALLPAPER=""
while IFS= read -r wallpaper_path; do
    if [[ "$(basename "$wallpaper_path")" == "$selected" ]]; then
        CHOSEN_WALLPAPER="$wallpaper_path"
        break
    fi
done < <(find_wallpapers)

# Set the chosen wallpaper with swww
if [[ -n "$CHOSEN_WALLPAPER" && -f "$CHOSEN_WALLPAPER" ]]; then
    echo "Setting wallpaper: $CHOSEN_WALLPAPER"
    swww img "$CHOSEN_WALLPAPER" \
        --transition-type "$TRANSITION" \
        --transition-step "$TRANSITION_STEP" \
        --transition-duration "$TRANSITION_DURATION"

    # Save the current wallpaper path for future reference
    echo "$CHOSEN_WALLPAPER" > "$HOME/.cache/current_wallpaper"

    echo "Wallpaper set successfully!"
else
    echo "Error: Selected wallpaper file not found: $selected"
    exit 1
fi
