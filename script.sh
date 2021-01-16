#!/bin/bash



function print_status {
    echo
    echo "## $1"
    echo
}


if test -t 1; then # if terminal
   nocolors=$(which tput > /dev/null && tput colors) # supports colors
   if test -n "$nocolors" && test $nocolors -ge 8; then
       termcols=$(tput cols)
       bold="$(tput bold)"
       underline="$(tput smul)"
       standout="$(tput smso)"
       normal="$(tput sgr0)"
       black="$(tput setaf 0)"
       red="$(tput setaf 1)"
       green="$(tput setaf 2)"
       yellow="$(tput setaf 3)"
       blue="$(tput setaf 4)"
       megenta="$(tput setaf 5)"
       cyan="$(tput setaf 6)"
       white="$(tput setaf 7)"
   fi
fi


print_status "running a color test..."
echo "${bold}this is bold! ${normal}"
echo "${underline}underline me! ${normal}"
echo "${standout}I should standout here! ${normal}"
echo "${black}this is black ${normal}"
echo "${red}this is red ${normal}"
echo "${green}this is green ${normal}"
echo "${yellow}this is yellow ${normal}"
echo "${blue}this is blue ${normal}"
echo "${megenta}this is megenta ${normal}"
echo "${cyan}this is cyan ${normal}"
echo "${white}this is white ${normal}"

print_status "end of color test..."



function die {
    MESS="$1"
    EXIT_VAL="${2:-1}"
    echo 1>&2 "$MESS"
    exit "$EXIT_VAL"
}


function exec_cmd_no_die {
    echo "+ $1"
    bash -c "$1"
}


function exec_cmd {
  exec_cmd_no_die "$1" || die "ERROR: could not exec $1" 15
}


AM_I_ROOT="$(id -u)"
[[ $AM_I_ROOT -eq 0 ]] || die "must be root to run this...."





print_status " ${bold}${green}checking for required packages...${normal}"

INSTALL_ME=""
[[ -z $(which git) ]] && INSTALL_ME="${INSTALL_ME} git"
[[ -z $(which curl) ]] && INSTALL_ME="${INSTALL_ME} curl"
[[ -z $(which wget) ]] && INSTALL_ME="${INSTALL_ME} wget"


if [ "X${INSTALL_ME}" != "X" ]; then
    print_status "Installing packages required for setup: ${INSTALL_ME}..."
    exec_cmd "apt install -y${INSTALL_ME} > /dev/null 2>&1"
fi


# docker
[[ -z $(which docker) ]] && print_status "${bold}${red}No docker found${normal}" 
[[ -z $(which docker) ]] && print_status "${cyan} Installing docker now....${normal}"  curl -fsSL https://get.docker.com/ | sh


# docker-compose
[[ -z $(which docker-compose) ]] && print_status "${bold}${red}No docker-compose found, installing it now${normal}"
[[ -z $(which docker-compose) ]] && curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


echo "${bold}${yellow}last line, exiting now${normal}"
exit 0


