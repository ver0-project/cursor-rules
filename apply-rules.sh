#!/bin/bash

set -e

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
GRAY="\033[0;90m"
RESET="\033[0m"

# Initialize variables
OVERWRITE=false
TARGET_DIR=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --ow)
            OVERWRITE=true
            shift
            ;;
        *)
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$1"
            else
                echo -e "${RED}❌ Unknown argument: $1${RESET}"
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if target directory is provided
if [ -z "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Usage: $0 [--ow] <target_directory>${RESET}"
    echo -e "${BLUE}   --ow: Overwrite existing rules${RESET}"
    exit 1
fi

echo -e "${GRAY}====${RESET}"
echo -e "${GRAY}Repository: https://github.com/ver0-project/cursor-rules${RESET}"
echo -e "${GRAY}====${RESET}\n"

RULES_DIR="$TARGET_DIR/.cursor/rules"
RAW_URL="https://raw.githubusercontent.com/ver0-project/cursor-rules/refs/heads/master/.cursor/rules"

# Check for required commands
for cmd in curl mkdir; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}❌ Error: Required command '$cmd' not found${RESET}"
        exit 1
    fi
done

# Ensure target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${BLUE}📁 Creating target directory: $TARGET_DIR${RESET}"
    mkdir -p "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error: Failed to create target directory $TARGET_DIR${RESET}"
        exit 1
    fi
fi

# Ensure .cursor/rules directory exists
if [ ! -d "$RULES_DIR" ]; then
    echo -e "${BLUE}📁 Creating rules directory: $RULES_DIR${RESET}"
    mkdir -p "$RULES_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error: Failed to create rules directory $RULES_DIR${RESET}"
        exit 1
    fi
fi

# Download a single file
download_file() {
    local rule_path="$1"
    local target_file="$RULES_DIR/$rule_path"
    local dir_path=$(dirname "$target_file")
    
    # Check if file exists and we're not in overwrite mode
    if [ -f "$target_file" ] && [ "$OVERWRITE" = false ]; then
        echo -e "${YELLOW}⚠️ Skipping existing file: $rule_path${RESET}"
        return 0
    fi
    
    local url="$RAW_URL/$rule_path"
    echo -e "${BLUE}📦 Downloading $rule_path${RESET}"
    
    # Create directory if it doesn't exist
    mkdir -p "$dir_path"
    
    # Download file
    local status=$(curl -s -o "$target_file" -w "%{http_code}" "$url")
    
    if [ "$status" != "200" ]; then
        echo -e "${YELLOW}⚠️ Warning: Failed to download $rule_path (HTTP Status: $status)${RESET}"
        return 1
    fi
    
    return 0
}

# Function to download rules
download_rules() {
    echo -e "${BLUE}📦 Downloading rules to $RULES_DIR${RESET}"
    
    RULES=(
        # Core rules
        "core/coding-principles.mdc"
        "core/cursor-rules.mdc"
        "core/emoji-usage.mdc"
        
        # Lng rules
        "lng/markdown/formatting.mdc"
        "lng/markdown/readme-formatting.mdc"
        
        # Tools rules
        "tools/commit-message.mdc"
        "tools/git-no-pager.mdc"
        "tools/unix-directory-listing.mdc"
        "tools/windows-directory-listing.mdc"
        
        # Local rules would be added here if any exist
    )
    
    # Count rules
    local rule_count=${#RULES[@]}
    echo -e "${GREEN}✅ Found $rule_count rules to download${RESET}"
    
    # Process each rule file
    for rule in "${RULES[@]}"; do
        download_file "$rule"
    done
    
    echo -e "${GREEN}🚀 All rules downloaded successfully to $RULES_DIR${RESET}"
}

# Main execution
download_rules 