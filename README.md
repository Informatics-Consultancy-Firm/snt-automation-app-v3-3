# SNT Automation Tools - PWA Setup

## File Structure

```
snt-pwa/
├── index.html          # Main app (PWA-enabled)
├── manifest.json       # PWA manifest
├── sw.js               # Service worker for offline support
├── offline.html        # Offline fallback page
├── browserconfig.xml   # Windows tile config
├── icons/              # App icons
│   ├── icon.svg        # Source SVG (edit this)
│   ├── icon-*.png      # Generated icons
│   └── icon-maskable-*.png
├── generate-icons.sh   # Bash icon generator
├── generate-icons.py   # Python icon generator
└── README.md
```

## GitHub Pages Deployment

### Option 1: Deploy from Root (Recommended)

1. Create a new repo (e.g., `snt-tools`)
2. Copy all files to the root of the repo
3. Push to GitHub
4. Go to **Settings > Pages > Source: main branch, / (root)**

Your URL will be: `https://username.github.io/snt-tools/`

### Option 2: Deploy from /docs Folder

1. Create a `/docs` folder in your repo
2. Copy all PWA files into `/docs`
3. Push to GitHub
4. Go to **Settings > Pages > Source: main branch, /docs**

Your URL will be: `https://username.github.io/repo-name/`

### Quick Deploy Commands

```bash
# Extract and enter directory
unzip snt-pwa.zip
cd snt-pwa

# Initialize git
git init
git add .
git commit -m "SNT Tools PWA"

# Create GitHub repo first, then:
git remote add origin https://github.com/YOUR_USERNAME/snt-tools.git
git branch -M main
git push -u origin main

# Enable GitHub Pages in Settings > Pages
```

## Generate Custom Icons

### Option A: Online Tool (Easiest)
1. Go to https://realfavicongenerator.net/
2. Upload your icon (512x512 PNG or SVG)
3. Download the generated package
4. Copy icons to the `icons/` folder

### Option B: Command Line (ImageMagick)
```bash
# Install ImageMagick
# Ubuntu/Debian: sudo apt install imagemagick
# macOS: brew install imagemagick

chmod +x generate-icons.sh
./generate-icons.sh your-logo.png
```

### Option C: Python Script
```bash
pip install Pillow cairosvg
python generate-icons.py your-logo.png
```

## Test Locally

Service workers require HTTPS or localhost:

```bash
# Python 3
python -m http.server 8000

# Node.js
npx serve .

# Then open: http://localhost:8000
```

## Features

- **Installable**: Users see "Install App" prompt
- **Offline Support**: Works without internet (cached pages)
- **Auto-Update**: Notifies users when new version available
- **Responsive**: Works on mobile and desktop
- **Deep Links**: Direct links to sections (#section1, #section2, etc.)

## Customizing Icons

1. Edit `icons/icon.svg` with your design
2. Run the icon generator script
3. Redeploy

### Icon Requirements

| Size | Purpose |
|------|---------|
| 16x16 | Browser favicon |
| 32x32 | Browser favicon |
| 72x72 | Android/iOS |
| 96x96 | Android |
| 128x128 | Chrome Web Store |
| 144x144 | Windows tiles |
| 152x152 | iOS |
| 192x192 | Android (required) |
| 384x384 | Android splash |
| 512x512 | Android/PWA (required) |
| maskable-192 | Android adaptive icons |
| maskable-512 | Android adaptive icons |

### Maskable Icons

Maskable icons need extra padding (safe zone). The icon content should be in the center 80% of the image. Use https://maskable.app/ to test.

## Troubleshooting

### PWA not installing?
- Must be served over HTTPS (or localhost)
- Check manifest.json is valid: https://manifest-validator.appspot.com/
- Check service worker is registered (DevTools > Application)

### Service worker not updating?
- Hard refresh: Ctrl+Shift+R (or Cmd+Shift+R on Mac)
- Clear cache in DevTools > Application > Storage > Clear site data

### Icons not showing?
- Check file paths in manifest.json
- Ensure icons are in PNG format
- Check browser console for 404 errors

## Testing PWA

1. **Chrome DevTools**: Application tab > Manifest/Service Workers
2. **Lighthouse**: Run audit for PWA score
3. **PWA Builder**: https://www.pwabuilder.com/

## Converting to Desktop App

If you need a native desktop app (.exe, .dmg):

### Using PWA Builder
1. Go to https://www.pwabuilder.com/
2. Enter your deployed URL
3. Download packages for Windows/Mac/Linux

### Using Electron (Advanced)
```bash
npm init -y
npm install electron electron-builder --save-dev
# Create main.js and package.json config
npm run dist
```

---

## Credits

Informatics Consultancy Firm - Sierra Leone (ICF-SL)
National Malaria Control Programme
Ministry of Health and Sanitation, Sierra Leone

© 2025 ICF-SL
