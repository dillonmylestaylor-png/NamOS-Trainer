#!/bin/bash
# NamOS Trainer Setup Script
# Run this after authenticating gh: gh auth login --web

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "NamOS Trainer Setup"
echo "=================="
echo ""

# Check if gh is authenticated
if ! gh auth status &>/dev/null; then
    echo -e "${RED}Error: gh is not authenticated.${NC}"
    echo "Run this first:"
    echo "  gh auth login --web"
    echo ""
    exit 1
fi

# Get GitHub username
USERNAME=$(gh api user -q '.login')
if [ -z "$USERNAME" ]; then
    echo -e "${RED}Error: Could not get GitHub username.${NC}"
    exit 1
fi

echo -e "GitHub username: ${GREEN}$USERNAME${NC}"

# Check if repo exists
if gh repo view "$USERNAME/NamOS-Trainer" &>/dev/null; then
    echo -e "${YELLOW}Repo NamOS-Trainer already exists.${NC}"
    read -p "Delete and recreate? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deleting existing repo..."
        gh repo delete "$USERNAME/NamOS-Trainer" --yes
    else
        echo "Exiting..."
        exit 0
    fi
fi

# Create repo
echo "Creating GitHub repo..."
cd /Users/juniper/Documents/OG\ NAM/NeuralAmpModelerPlugin-V1\ copy/NamOS-Trainer
gh repo create NamOS-Trainer --public --source=. --push --description "Multi-rate conditioning trainer for Neural Amp Modeler"

# Update links in files
if [ -f "netlify/index.html" ]; then
    sed -i '' "s|YOUR_USERNAME|$USERNAME|g" netlify/index.html
    echo -e "${GREEN}Updated netlify/index.html with username${NC}"
fi

# Commit and push
git add .
git commit -m "Update Colab link with username" || echo "No changes to commit"
git push origin main

echo ""
echo -e "${GREEN}✓ GitHub repo created: https://github.com/$USERNAME/NamOS-Trainer${NC}"
echo ""
echo "Next steps:"
echo "1. Go to https://netlify.com/drop"
echo "2. Drag the netlify/ folder onto the page"
echo "3. Your site will be live instantly!"
echo ""
echo "For custom domain later:"
echo "- Netlify → Site settings → Domain management → Add custom domain"
echo "- Point your domain's DNS to Netlify (or use Netlify DNS)"
echo ""
