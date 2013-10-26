#!/bin/bash

# Enable text selection in preview
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Install macfuse and sshfs and make automount work
brew install osxfuse sshfs
sudo ln -s /usr/local/bin/sshfs /sbin/mount_sshfs
sudo automount -c
sudo -s echo '#dummy:root@alexg-centos:/home/alexg /sshfs/alexg-centos sshfs volname=volname,noforget,uid=501,gid=20,allow_other 0 0' >> /etc/fstab
