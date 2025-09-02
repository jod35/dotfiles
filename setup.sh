
#!/bin/bash

# move to home directory


echo "Copying configuration files to ~/.config..."
# Create directories if they don't exist

mkdir -p ~/.config/polybar
mkdir -p ~/.config/i3
mkdir -p ~/.config/terminator
mkdir -p ~/.config/rofi
mkdir -p ~/.config/picom

# Copy configuration files
cp -r polybar/config ~/.config/polybar/
cp -r i3/config ~/.config/i3/
cp -r terminator/config ~/.config/terminator/
cp -r rofi/config.rasi ~/.config/rofi/
cp -r picom/picom.conf ~/.config/picom/

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

# Install dependencies
echo "Installing Bumblebee status dependencies..."

cd ~

git clone https://github.com/gabrielelana/awesome-terminal-fonts.git

cd awesome-terminal-fonts

mv build/*.tff ~/.fonts/

mv build/*.sh ~/.fonts/

fc-cache -fv

cd ~

# install i3 if not installed
if ! command -v i3 &> /dev/null; then
    echo "i3 could not be found, installing..."
    sudo apt-get update
    sudo apt-get install -y i3
else
    echo "i3 is already installed."
fi

# install nitrogen if not installed
if ! command -v nitrogen &> /dev/null; then
    echo "nitrogen could not be found, installing..."
    sudo apt-get update
    sudo apt-get install -y nitrogen
else
    echo "nitrogen is already installed."
fi

# get wallpapers from DT
if [ ! -d "$HOME/Pictures/Wallpapers" ]; then
    echo "Cloning DT wallpapers..."
    git clone https://gitlab.com/dwt1/wallpapers.git
    mkdir -p "$HOME/.walls"
    mv wallpapers "$HOME/.walls"
else
    echo "Wallpapers already exist."
fi

# set wallpaper using nitrogen
nitrogen --set-auto "$HOME/.walls/wallpapers" --save


# install docker if not installed
if ! command -v docker &> /dev/null; then
    echo "docker could not be found, installing..."
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update 

    # Install Docker Engine
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Manage Docker as a non-root user
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker   

    # Verify that Docker Engine is installed correctly by running the hello-world image.
    sudo docker run hello-world
else
    echo "docker is already installed."
fi

echo "Setup complete! Please restart your terminal or log out and back in for all changes to take effect."
