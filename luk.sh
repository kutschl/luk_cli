#!/bin/bash

# set -e error handling ! 

# command [OPTIONS] arguments

echo "luk CLI loaded."

alias source_bash='source ~/.bashrc'
alias nano_bash='nano ~/.bashrc'

function _cd(){
    if [ $# -eq 0 ]; then
        echo "luk cd: missing argument DIRECTORY"
        return 1
    fi

    DIRECTORY=$1
    case "$DIRECTORY" in
        racestack | race | rs | race_stack | larace)
            cd ~/race_stack || return 1
            return 0
            ;;
        cv)
            cd ~/cv || return 1
            return 0
            ;;
        *)
            echo "luk cd: unknown directory alias: $DIRECTORY"
            return 1
            ;;
    esac
}

function _code(){
    if [ $# -eq 0 ]; then
        echo "luk code: missing argument FILE"
        return 1
    fi

    REPO=$1
    case "$REPO" in
        racestack | race | rs | race_stack | larace)
            code ~/race_stack && exit 0
            ;;
        cv)
            code ~/cv && exit 0
            ;;
        *)
            echo "luk code: unknown repository alias: $REPO"
            return 1
            ;;
    esac
}

function _bash(){
    if [ $# -eq 0 ]; then
        echo "luk bash: missing argument CMD"
        return 1
    fi

    CMD=$1
    case "$CMD" in
        nano)
            nano ~/.bashrc && source ~/.bashrc
            ;;
        source)
            source ~/.bashrc
            ;;
        *)
            echo "luk bash: unknown bash command: $CMD"
            return 1
            ;;
    esac    
}

function _update() {
    echo "Updating luk..."
    sudo apt-get update > /dev/null
    sudo apt-get upgrade -y > /dev/null
    sudo apt-get autoremove -y > /dev/null
    echo "Luk updated."
}

function _help(){
    echo "luk: a simple shell wrapper"
    echo ""
    echo "Usage: luk [COMMAND] [OPTIONS] [ARGUMENTS]"
    echo ""
    echo "Commands:"
    echo "  cd [DIRECTORY]      Change the current directory to DIRECTORY."
    echo "  help                Display this help message."
    echo ""
    echo "Use 'luk COMMAND --help' for more information on a specific command."
}


function luk(){

    N_ARGS=$#
    
    if [ $N_ARGS -eq 0 ]; then
        COMMAND="help"
    else
        COMMAND=$1
        N_ARGS=$(expr $N_ARGS - 1) 
        shift
    fi

    case "$COMMAND" in
        cd)
            _cd $@
            ;;
        code)
            _code $@
            ;;
        help)
            _help $@
            ;;
        update)
            _update $@
            ;;
        bash)
            _bash $@
            ;;
        *)
            echo "luk: command not found: $COMMAND"
            ;;

    esac         
    
}

