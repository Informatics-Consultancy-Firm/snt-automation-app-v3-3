#!/bin/bash

# SNT Tools - Icon Generator Script
# Requires: ImageMagick (convert command)
# Usage: ./generate-icons.sh [source_image]

SOURCE="${1:-icons/icon.svg}"
OUTPUT_DIR="icons"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed."
    echo "Install with:"
    echo "  Ubuntu/Debian: sudo apt install imagemagick"
    echo "  macOS: brew install imagemagick"
    echo "  Windows: https://imagemagick.org/script/download.php"
    exit 1
fi

# Check if source file exists
if [ ! -f "$SOURCE" ]; then
    echo "Error: Source file '$SOURCE' not found."
    echo "Please provide a source image (SVG or PNG, 512x512 recommended)"
    exit 1
fi

echo "Generating icons from: $SOURCE"
echo "Output directory: $OUTPUT_DIR"
echo ""

# Create output directory if needed
mkdir -p "$OUTPUT_DIR"

# Standard icon sizes
SIZES=(16 32 57 60 72 76 96 114 120 128 144 152 180 192 384 512)

for size in "${SIZES[@]}"; do
    echo "Creating icon-${size}.png..."
    convert "$SOURCE" -resize ${size}x${size} -background none -gravity center -extent ${size}x${size} "$OUTPUT_DIR/icon-${size}.png"
done

# Create maskable icons (with padding for safe zone)
echo "Creating maskable icons..."
# Maskable icons need content in center 80%, so we add 10% padding on each side
convert "$SOURCE" -resize 154x154 -background "#004080" -gravity center -extent 192x192 "$OUTPUT_DIR/icon-maskable-192.png"
convert "$SOURCE" -resize 410x410 -background "#004080" -gravity center -extent 512x512 "$OUTPUT_DIR/icon-maskable-512.png"

# Create favicon.ico (multi-size)
echo "Creating favicon.ico..."
convert "$SOURCE" -resize 16x16 "$OUTPUT_DIR/favicon-16.png"
convert "$SOURCE" -resize 32x32 "$OUTPUT_DIR/favicon-32.png"
convert "$SOURCE" -resize 48x48 "$OUTPUT_DIR/favicon-48.png"
convert "$OUTPUT_DIR/favicon-16.png" "$OUTPUT_DIR/favicon-32.png" "$OUTPUT_DIR/favicon-48.png" "$OUTPUT_DIR/favicon.ico"
rm "$OUTPUT_DIR/favicon-16.png" "$OUTPUT_DIR/favicon-32.png" "$OUTPUT_DIR/favicon-48.png"

# Copy SVG for Safari
if [[ "$SOURCE" == *.svg ]]; then
    echo "Copying SVG for Safari pinned tab..."
    cp "$SOURCE" "$OUTPUT_DIR/safari-pinned-tab.svg"
fi

echo ""
echo "Done! Icons generated in $OUTPUT_DIR/"
echo ""
echo "Next steps:"
echo "1. Review the generated icons"
echo "2. For maskable icons, test at https://maskable.app/"
echo "3. Deploy your PWA"
