#!/usr/bin/env bash

# Interactive Dotfiles Installer for atefBB/dotfiles
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/atefBB/dotfiles"
TEMP_DIR="/tmp/dotfiles_install_$(date +%s)"

# Function to print colored messages
print_message() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to ask yes/no questions
ask_yes_no() {
    while true; do
        read -rp "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to install fish configuration
install_fish() {
    print_message "Installing fish configuration..."
    
    if [ -d "fish_functions" ]; then
        FISH_FUNC_DIR="$HOME/.config/fish/functions"
        
        # Create directory if it doesn't exist
        mkdir -p "$FISH_FUNC_DIR"
        
        # Copy fish functions
        cp -r fish_functions/* "$FISH_FUNC_DIR/"
        print_success "Fish functions installed to $FISH_FUNC_DIR"
    else
        print_warning "fish_functions directory not found"
    fi
}

# Function to install Neovim configuration
install_neovim() {
    print_message "Installing Neovim configuration..."
    
    if [ -f "init.vim" ]; then
        NVIM_DIR="$HOME/.config/nvim"
        
        # Create directory if it doesn't exist
        mkdir -p "$NVIM_DIR"
        
        # Copy init.vim
        cp init.vim "$NVIM_DIR/"
        print_success "init.vim installed to $NVIM_DIR"
        
        # Offer to install vim-plug
        if ask_yes_no "Do you want to install vim-plug for Neovim?"; then
            print_message "Installing vim-plug..."
            
            # Download vim-plug
            sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            
            print_success "vim-plug installed"
            print_message "After installation, restart nvim and run :PlugInstall to install plugins"
        fi
    else
        print_warning "init.vim not found"
    fi
}

# Function to install shell dotfiles
install_shell_dotfiles() {
    print_message "Installing shell dotfiles..."
    
    # Array of dotfiles to install
    declare -a dotfiles=(
        ".bash_profile"
        ".bashrc"
        ".gitconfig"
        ".git-prompt.sh"
        ".nanorc"
        ".prettierrc"
        ".vimrc"
    )
    
    for file in "${dotfiles[@]}"; do
        if [ -f "$file" ]; then
            # Backup existing file if it exists
            if [ -f "$HOME/$file" ]; then
                if ask_yes_no "Backup existing $file?"; then
                    backup_file="$HOME/${file}.backup_$(date +%Y%m%d_%H%M%S)"
                    cp "$HOME/$file" "$backup_file"
                    print_success "Backed up $file to $backup_file"
                fi
            fi
            
            # Copy the file
            cp "$file" "$HOME/"
            print_success "Installed $file"
        else
            print_warning "$file not found in repository"
        fi
    done
}

# Function to install additional files
install_additional_files() {
    print_message "Checking for additional files..."
    
    # Install skeleton.html if it exists
    if [ -f ".skeleton.html" ]; then
        if ask_yes_no "Install .skeleton.html to $HOME?"; then
            cp ".skeleton.html" "$HOME/"
            print_success "Installed .skeleton.html"
        fi
    fi
    
    # Install font if it exists
    if [ -f "JetBrains Mono Medium Italic Nerd Font Complete.ttf" ]; then
        if ask_yes_no "Install JetBrains Mono Nerd Font?"; then
            print_message "Font installation varies by system. You may need to:"
            print_message "1. Copy the .ttf file to your fonts directory"
            print_message "2. Update font cache (fc-cache -fv)"
        fi
    fi
    
    # Check for bin directory
    if [ -d "bin" ]; then
        if ask_yes_no "Install scripts from bin directory to ~/bin?"; then
            mkdir -p "$HOME/bin"
            cp -r bin/* "$HOME/bin/"
            chmod +x "$HOME/bin/"*
            print_success "Installed bin scripts"
        fi
    fi
}

# Main installation function
main_installation() {
    print_message "Starting interactive dotfiles installation from $REPO_URL"
    echo "=========================================="
    
    # Clone the repository
    print_message "Cloning repository to $TEMP_DIR..."
    git clone "$REPO_URL" "$TEMP_DIR"
    cd "$TEMP_DIR" || exit 1
    
    # Show repository contents
    print_message "Repository contents:"
    ls -la
    
    echo ""
    print_message "Available components to install:"
    echo "1. Shell dotfiles (.bashrc, .gitconfig, etc.)"
    echo "2. Fish shell functions"
    echo "3. Neovim configuration"
    echo "4. Additional files (skeleton.html, bin scripts, font)"
    echo "5. All components"
    echo ""
    
    # Get user choice
    read -rp "Choose components to install (1-5, comma-separated for multiple): " choices
    
    # Process choices
    IFS=', ' read -r -a choice_array <<< "$choices"
    
    for choice in "${choice_array[@]}"; do
        case $choice in
            1)
                install_shell_dotfiles
                ;;
            2)
                install_fish
                ;;
            3)
                install_neovim
                ;;
            4)
                install_additional_files
                ;;
            5)
                install_shell_dotfiles
                install_fish
                install_neovim
                install_additional_files
                break
                ;;
            *)
                print_warning "Invalid choice: $choice"
                ;;
        esac
    done
    
    # Cleanup
    print_message "Cleaning up temporary directory..."
    rm -rf "$TEMP_DIR"
    
    print_success "Installation completed!"
    print_message "Note: Some changes may require restarting your shell or applications."
}

# Error handling
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
    print_message "Cleanup completed"
}

# Set trap for cleanup
trap cleanup EXIT

# Check for prerequisites
check_prerequisites() {
    if ! command -v git &> /dev/null; then
        print_error "git is not installed. Please install git first."
        exit 1
    fi
    
    if ! command -v curl &> /dev/null && ask_yes_no "curl not found. Required for vim-plug. Install?"; then
        print_error "Please install curl manually and run the script again."
        exit 1
    fi
}

# Start installation
check_prerequisites
main_installation
