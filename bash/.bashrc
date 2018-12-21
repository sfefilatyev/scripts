# .bashrc

# User specific aliases and functions

#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -la'
alias dock2local2='docker exec -it rumpy-docker2 "/bin/bash"'

unset HISTFILESIZE
HISTSIZE=100000

export LANG=en_US.utf8

#starts an instance of the container referenced by the first argument (its id)
function dock(){
	docker run -ti -v /:/ext -v /data:/data -u ubuntu --device /dev/nvidia1:/dev/nvidia1 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm --name sergiy-instance  $1 "/bin/bash"	
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export CUDA_HOME=/usr/local/cuda
export CUDA_VISIBLE_DEVICES=0,1

export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH
#----------------------------- VARIABLES ---------------------------------------------------------------------------

export PATH="/bin/:/sbin/:/usr/sbin/:/usr/local/sbin/:/usr/local/cuda/bin/:$PATH"



#-------------------------------------------------------------------------------------------------------------------
function prompt_command {

TERMWIDTH=${COLUMNS}

#   Calculate the width of the prompt:

hostnam=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
#   "whoami" and "pwd" include a trailing newline
usernam=$(whoami)
cur_tty=$(tty | sed -e "s/.*tty\(.*\)/\1/")
newPWD="${PWD}"
#   Add all the accessories below ...
let promptsize=$(echo -n "--(${usernam}@${hostnam}:${cur_tty})---(${PWD})--" \
                 | wc -c | tr -d " ")
let fillsize=${TERMWIDTH}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}-"
	let fillsize=${fillsize}-1
done

if [ "$fillsize" -lt "0" ]
then
   let cut=3-${fillsize}
	newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
fi
}

PROMPT_COMMAND=prompt_command

function twtty {

local GRAY="\[\033[1;30m\]"
local LIGHT_GRAY="\[\033[0;37m\]"
local WHITE="\[\033[1;37m\]"
local NO_COLOUR="\[\033[0m\]"
local RED="\[\033[1;31m\]"
local GREEN="\[\033[0;32m\]"
local LIGHT_BLUE="\[\033[1;34m\]"
local YELLOW="\[\033[1;33m\]"

case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="$TITLEBAR\
$LIGHT_BLUE-$YELLOW-(\
$RED\$usernam$YELLOW@$GREEN\$hostnam$YELLOW:$WHITE\$cur_tty\
${YELLOW})-${LIGHT_BLUE}-\${fill}${YELLOW}-(\
$RED\${newPWD}\
$YELLOW)-$LIGHT_BLUE-\
\n\
$YELLOW-$LIGHT_BLUE-(\
$YELLOW\$(date +%H%M)$LIGHT_BLUE:$YELLOW\$(date \"+%a,%d %b %y\")\
$LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)-\
$YELLOW-\
$NO_COLOUR " 

PS2="$LIGHT_BLUE-$YELLOW-$YELLOW-$NO_COLOUR "

}
#--------------------------------------------------------------------------------------------------------------------
twtty
clear 

# added by Anaconda3 4.2.0 installer
#export PATH="/usr/local/anaconda3/bin:$PATH"
#export PATH="/home/sfefilatyev/.local/bin/:$PATH"
export JAVA_HOME=/opt/jdk1.8.0_151
export PATH=/opt/jdk1.8.0_151/bin:$PATH 
export CLASSPATH=/opt/jdk1.8.0_151/lib
cd /home/sfefilatyev/projects/ai-infra; source scripts/envsetup.sh
export ECLIPSE_HOME=/opt/eclipse/eclipse/
