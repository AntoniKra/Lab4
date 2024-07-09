#!/bin/bash


function display_help {
    echo "Usage: ./my_script.sh [--date | -d | --logs | -l [N] | --error | -e [N] | --help | -h]"
    echo "--date, -d       Display today's date"
    echo "--logs, -l       Create log files (default: 100)"
    echo "--logs, -l N     Create N log files"
    echo "--error, -e      Create error files (default: 100)"
    echo "--error, -e N    Create N error files"
    echo "--help, -h       Display this help message"
    echo "--init           Clone repository and set PATH environment variable"
}


function create_logs {
    local num_logs=${1:-100}  
    for (( i=1; i<=$num_logs; i++ ))
    do
        filename="log${i}.txt"
        echo "File: $filename" > $filename
        echo "Created by: $0" >> $filename
        echo "Date: $(date)" >> $filename
    done
}


function create_errors {
    local num_errors=${1:-100}  
    mkdir -p errors
    for (( i=1; i<=$num_errors; i++ ))
    do
        filename="errors/error${i}.txt"
        echo "Error file: $filename" > $filename
        echo "Created by: $0" >> $filename
        echo "Date: $(date)" >> $filename
    done
}


if [[ $# -eq 0 ]]; then
    display_help
    exit 1
fi

case "$1" in
    --date | -d)
        echo "Today's date is: $(date)"
        ;;
    --logs | -l)
        if [[ -z "$2" ]]; then
            create_logs
        else
            re='^[0-9]+$'
            if ! [[ $2 =~ $re ]]; then
                echo "Error: Argument for --logs/--l must be a positive integer."
                exit 1
            fi
            create_logs $2
        fi
        ;;
    --error | -e)
        if [[ -z "$2" ]]; then
            create_errors
        else
            re='^[0-9]+$'
            if ! [[ $2 =~ $re ]]; then
                echo "Error: Argument for --error/--e must be a positive integer."
                exit 1
            fi
            create_errors $2
        fi
        ;;
    --help | -h)
        display_help
        ;;
    --init)
        
        git clone .
        export PATH=$PATH:$(pwd)
        ;;
    *)
        echo "Error: Invalid option. Use --help/-h for usage information."
        exit 1
        ;;
esac
