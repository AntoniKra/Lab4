#!/bin/bash


function display_help {
    echo "Usage: ./my_script.sh [--date | --logs [N] | --help]"
    echo "--date          Display today's date"
    echo "--logs          Create log files (default: 100)"
    echo "--logs N        Create N log files"
    echo "--help          Display this help message"
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


if [[ $# -eq 0 ]]; then
    display_help
    exit 1
fi

case "$1" in
    --date)
        echo "Today's date is: $(date)"
        ;;
    --logs)
        if [[ -z "$2" ]]; then
            create_logs
        else
            re='^[0-9]+$'
            if ! [[ $2 =~ $re ]]; then
                echo "Error: Argument for --logs must be a positive integer."
                exit 1
            fi
            create_logs $2
        fi
        ;;
    --help)
        display_help
        ;;
    *)
        echo "Error: Invalid option. Use --help for usage information."
        exit 1
        ;;
esac
