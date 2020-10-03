# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
#
# NOTE this file is not sourced by lightdm when logging in to X sessions.
# Use .xsessionrc for graphical sessions.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] && [ -z "$DID_BASHRC" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set tty colours.
if [ "$TERM" = "linux" ]; then
    printf "\e]P0000000" # color0
    printf "\e]P19e1828" # color1
    printf "\e]P2aece92" # color2
    printf "\e]P3968a38" # color3
    printf "\e]P4414171" # color4
    printf "\e]P5963c59" # color5
    printf "\e]P6418179" # color6
    printf "\e]P7bebebe" # color7
    printf "\e]P8888888" # color8
    printf "\e]P9cf6171" # color9
    printf "\e]PAc5f779" # color10
    printf "\e]PBfff796" # color11
    printf "\e]PC4186be" # color12
    printf "\e]PDcf9ebe" # color13
    printf "\e]PE71bebe" # color14
    printf "\e]PFffffff" # color15
#   clear # removes artefacts but also removes /etc/{issue,motd}
fi

export ODBCINI=${HOME}/etc/odbc.ini
export ODBCSYSINI=${HOME}/etc
export FREETDSCONF=${HOME}/etc/freetds.conf
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export MSSQL_CLI_TELEMETRY_OPTOUT=1

if [ ! -d "${HOME}/.cargo" ]; then
  # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  true
fi

if [ ! -d "${HOME}/.nvm" ]; then
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  true
fi
