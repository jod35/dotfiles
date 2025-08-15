
#!/bin/bash

# move to home directory

cd ~

echo "Copying configuration files to ~/.config..."
# Create directories if they don't exist

mkdir -p .config/polybar
mkdir -p .config/i3
mkdir -p .config/terminator
mkdir -p .config/rofi
mkdir -p .config/picom

# Copy configuration files
cp -r polybar/config .config/polybar/
cp -r i3/config .config/i3/
cp -r terminator/config .config/terminator/
cp -r rofi/config.rasi .config/rofi/
cp -r picom/picom.conf .config/picom/

echo "Configuration files copied successfully."

echo "setting up Bumblebee status..."

# install git if not installed
if ! command -v git &> /dev/null; then
    echo "git could not be found, installing..."
    sudo apt-get update
    sudo apt-get install -y git
else
    echo "git is already installed."
fi

# Clone the Bumblebee status repository
if [ ! -d "$HOME/.bumblebee" ]; then
    echo "Cloning Bumblebee status repository..."
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status.git
else
    echo "Bumblebee status repository already exists."
fi

# rename bumblebee-status to .bumblebee
mv bumblebee-status "$HOME/.bumblebee"