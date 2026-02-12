#!/bin/bash
#
# Deploy to GitHub Pages
#

echo "🚀 Deploying Rubik's Cube Game to GitHub..."
echo ""

# Check if git user is configured
if ! git config user.name > /dev/null; then
    echo "❌ Git user not configured. Run:"
    echo "   git config --global user.name 'Your Name'"
    echo "   git config --global user.email 'your@email.com'"
    exit 1
fi

# Initialize git if needed
if [ ! -d .git ]; then
    git init
    git add .
    git commit -m "🎲 Initial commit - Rubik's Cube Game"
fi

# Get GitHub username
echo "Enter your GitHub username (or press Enter for 'ocean-wang'):"
read GH_USER
GH_USER=${GH_USER:-ocean-wang}

# Create repo if not exists
echo ""
echo "📦 Creating GitHub repository..."
curl -s -X POST "https://api.github.com/user/repos" \
  -H "Authorization: token $GH_TOKEN" \
  -d "{\"name\":\"rubiks-cube-game\",\"description\":\"Beautiful 3D Rubik's Cube game with AI hints\",\"private\":false}" 2>/dev/null

# Add remote
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GH_USER/rubiks-cube-game.git"

# Push to main
echo ""
echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main

# Enable GitHub Pages
echo ""
echo "🔗 GitHub Pages should be enabled automatically!"
echo "   URL: https://$GH_USER.github.io/rubiks-cube-game/"
echo ""
echo "✅ Done!"
