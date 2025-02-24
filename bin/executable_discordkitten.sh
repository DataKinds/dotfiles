#!/bin/bash

read -rp "Please enter the minor Discord version number: "
if [[ $REPLY =~ ^[[:digit:]]+$ ]]; then
	URL="https://dl.discordapp.net/apps/linux/0.0.$REPLY/discord-0.0.$REPLY.deb"
	DIR=$(mktemp -d)
    wget -O $DIR/discord.deb $URL
    if [[ -f $DIR/discord.deb ]]; then
        sudo dpkg -i $DIR/discord.deb
    else
        echo "There was a failure downloading the Discord update!"
    fi
else
    echo "You've entered an invalid Discord version number."
fi

