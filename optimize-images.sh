#!/bin/bash

# Image Optimization Script for Portfolio
# This script helps optimize images for web use

echo "🖼️  Portfolio Image Optimizer"
echo "================================"

# Create optimized images directory
mkdir -p images/optimized

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick not found. Please install it first:"
    echo "   macOS: brew install imagemagick"
    echo "   Ubuntu: sudo apt-get install imagemagick"
    exit 1
fi

echo "✅ ImageMagick found!"

# Function to optimize profile image
optimize_profile() {
    if [ -f "images/profile-original.jpg" ] || [ -f "images/profile-original.png" ]; then
        echo "🔄 Optimizing profile image..."
        
        # Find the original file
        if [ -f "images/profile-original.jpg" ]; then
            original="images/profile-original.jpg"
        else
            original="images/profile-original.png"
        fi
        
        # Create optimized profile image (400x400, circular crop ready)
        convert "$original" \
            -resize 400x400^ \
            -gravity center \
            -extent 400x400 \
            -quality 85 \
            "images/profile.jpg"
        
        echo "✅ Profile image optimized: images/profile.jpg"
    else
        echo "⚠️  No profile-original.jpg or profile-original.png found in images/"
    fi
}

# Function to optimize project images
optimize_projects() {
    echo "🔄 Looking for project images..."
    
    for file in images/project-*-original.*; do
        if [ -f "$file" ]; then
            # Extract project name from filename
            basename=$(basename "$file")
            project_name=${basename%-original.*}
            
            echo "🔄 Optimizing $project_name..."
            
            # Create optimized project image (800x400)
            convert "$file" \
                -resize 800x400^ \
                -gravity center \
                -extent 800x400 \
                -quality 85 \
                "images/${project_name}.jpg"
            
            echo "✅ $project_name optimized"
        fi
    done
}

# Function to optimize testimonial avatars
optimize_avatars() {
    echo "🔄 Looking for avatar images..."
    
    for file in images/avatar-*-original.*; do
        if [ -f "$file" ]; then
            # Extract avatar name from filename
            basename=$(basename "$file")
            avatar_name=${basename%-original.*}
            
            echo "🔄 Optimizing $avatar_name..."
            
            # Create optimized avatar (120x120)
            convert "$file" \
                -resize 120x120^ \
                -gravity center \
                -extent 120x120 \
                -quality 85 \
                "images/${avatar_name}.jpg"
            
            echo "✅ $avatar_name optimized"
        fi
    done
}

# Main execution
echo ""
echo "📁 Current images directory:"
ls -la images/ 2>/dev/null || echo "No images directory found"

echo ""
echo "🚀 Starting optimization..."

optimize_profile
optimize_projects
optimize_avatars

echo ""
echo "✅ Optimization complete!"
echo ""
echo "📋 Usage Instructions:"
echo "1. Place your original images in the images/ folder with these names:"
echo "   - profile-original.jpg (for your profile photo)"
echo "   - project-1-original.jpg (for first project)"
echo "   - project-2-original.jpg (for second project)"
echo "   - avatar-1-original.jpg (for testimonial avatars)"
echo ""
echo "2. Run this script: ./optimize-images.sh"
echo ""
echo "3. The optimized images will be created automatically!"
echo ""
echo "💡 Tip: You can also use online tools like TinyPNG or Squoosh.app"
