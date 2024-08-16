FROM ubuntu:20.04

# Set the DEBIAN_FRONTEND to noninteractive to suppress prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the image and install system packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    xvfb \
    zip \
    ca-certificates \
    gnupg \
    libnss3-dev \
    libasound2 \
    libxss1 \
    libappindicator3-1 \
    libindicator7 \
    gconf-service \
    libgconf-2-4 \
    libpango1.0-0 \
    xdg-utils \
    fonts-liberation \
    wmctrl

# Add Google's GPG key and set up the stable repository
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Update package lists and install Google Chrome
RUN apt-get update \
    && apt-get -y install google-chrome-stable

# Install required Python packages from requirements.txt
COPY ../requirements.txt /robot/requirements.txt
RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r /robot/requirements.txt

# Set environment variables for Chrome to run in headless mode
ENV ROBOT_SELENIUM_BROWSER=chrome
ENV ROBOT_SELENIUM_ARGUMENTS="--headless,--no-sandbox,--disable-dev-shm-usage,--disable-gpu,--window-size=1920x1080"

# Set the working directory
WORKDIR /robot

# Copy the current directory contents into the container at /robot
COPY .. /robot


