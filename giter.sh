#!/bin/bash

# Ensure we are in the directory where this script is located (bin folder)
cd "$(dirname "$0")"

# 1. Initialize the repo (if not already done)
if [ ! -d ".git" ]; then
    git init
fi

# 2. Add or update the remote
git remote add origin https://github.com/pastioke/onifast.git 2>/dev/null || \
git remote set-url origin https://github.com/pastioke/onifast.git

# 3. Create .gitignore to exclude the large panel binary
cat > .gitignore << 'EOF'
onifast-panel
EOF

# 4. Stage all files (excluding .gitignore-d files)
git add .

# 5. Commit using the version text
if [ -f "VERSION" ]; then
    VERSION_STR=$(cat VERSION)
else
    VERSION_STR="unknown"
fi

git commit -m "Release version: $VERSION_STR"

# 6. Ensure we are on the main branch
git branch -M main

# 7. Force push to overwrite the remote
git push -u origin main --force