#!/bin/bash

source ./config

while getopts ":help" option; do
    case $option in
    h)
        echo ""
        echo "This script show all PC information. "
        echo "Available distro: ${bold}Arch Linux, Ubuntu, and Tux${normal}"
        echo ""
        echo "Developer: ${bold}https://codeberg.org/rendick${normal}"
        echo ""
        exit
        ;;
    esac
done

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$NAME"
elif type lsb_release >/dev/null 2>&1; then
    DISTRO=$(lsb_release -si)
else
    DISTRO=$(uname -s)
fi

# Define logos for each supported distribution
case $DISTRO in
"Arch Linux")
    LOGO="
       /\\          ${cyan}$USER${none}@${cyan}$HOSTNAME${none}
      /  \\         ${cyan}os${none}     $DISTRO
     /    \\        ${cyan}host${none}   $HOSTNAME
    /      \\       ${cyan}kernel${none} $(uname -r)
   /   ,,   \\      ${cyan}uptime${none} $(uptime -p)
  /   |  |   \\     ${cyan}pkg${none}    $(pacman -Qq | wc -l)
 /_-''    ''-_\\    ${cyan}memory${none} $(free -h | awk '/Mem:/ {print $3 "/" $2}')
"
    ;;
"Ubuntu")
    LOGO="
           _        ${red}$USER${none}@${red}$HOSTNAME${none}        
       ---(_)       ${red}os${none}     $DISTRO
   _/  ---  \\       ${red}host${none}   $HOSTNAME
  (_) |   |   |     ${red}kernel${none} $(uname -r)
    \\  --- _/       ${red}uptime${none} $(uptime -p)
       ---(_)       ${red}pkgs${none}   $(pacman -Qq | wc -l)
                    ${red}memory${none} $(free -h | awk '/Mem:/ {print $3 "/" $2}')
"
    ;;
"Ubuntu")
    LOGO="
           _        ${red}$USER${none}@${red}$HOSTNAME${none}        
       ---(_)       ${red}os${none}     $DISTRO
   _/  ---  \\       ${red}host${none}   $HOSTNAME
  (_) |   |   |     ${red}kernel${none} $(uname -r)
    \\  --- _/       ${red}uptime${none} $(uptime -p)
       ---(_)       ${red}pkgs${none}   $(pacman -Qq | wc -l)
                    ${red}memory${none} $(free -h | awk '/Mem:/ {print $3 "/" $2}')
"
    ;;
# Add more cases for other distributions here
*)
    # Default logo for unknown distributions
    LOGO="
      ___           ${white}$USER${none}@${white}$HOSTNAME${none}
     (.. \          ${white}os${none}     $DISTRO
     (<> |          ${white}host${none}   $HOSTNAME
    /    \\\\          ${white}kernel${none} $(uname -r)
   ( |  |/|         ${white}uptime${none} $(uptime -p)
   /\\ __)/_)        ${white}pkgs${none}   $(pacman -Qq | wc -l)
   \_/-____\/        ${white}memory${none} $(free -h | awk '/Mem:/ {print $3 "/" $2}')

"
    ;;
esac

# Print logo
echo -e "$LOGO"
