#!/bin/bash

# Script version
version="1.0.0"

# Initialize variables
file=""
venv="start-script_venv"
requirements_file="requirements.txt"
log_file="/tmp/start_script.log"
verbose=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display usage information
usage() {
    echo -e "${YELLOW}Usage: $0 -f <python_file> [-e <virtual_env_name>] [-r <requirements_file>] [-v] [-V] [-h] [-c]${NC}"
    exit 1
}

# Log function
log() {
    local message=$1
    local color=$2
    echo -e "${color}${message}${NC}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") ${message}" >> $log_file
}

# Get the parameters with the -f, -e, -r, -v, -V, and -h flags
while getopts "f:e:r:vVhc" flag; do
    case "${flag}" in
        f) file=${OPTARG};;
        e) venv=${OPTARG};;
        r) requirements_file=${OPTARG};;
        v) verbose=1;;
        V) echo -e "${BLUE}Version: ${version}${NC}"; exit 0;;
        h) usage;;
        c) log "[SCRIPT] Created by Stefano Videsott: https://github.com/StefanoVidesott" "$BLUE"; exit 0;;
        *) log "[SCRIPT] Invalid option: -${OPTARG}" "$RED" >&2; usage;;
    esac
done

# Check for Python3 installation
if ! command -v python3 &> /dev/null; then
    log "[SCRIPT] Python3 is not installed" "$RED"
    exit 1
fi

# Check if the file parameter is provided
if [ -z "$file" ]; then
    log "[SCRIPT] The file parameter is missing" "$RED"
    usage
fi

# Check if requirements file exists
if [ ! -f "$requirements_file" ]; then
    log "[SCRIPT] $requirements_file not found!" "$RED"
    exit 1
fi

# Check if the virtual environment exists and create it if it doesn't
venv_dir="/tmp/$venv"
if [ -d "$venv_dir" ]; then
    log "[SCRIPT] Virtual environment exists" "$GREEN"
else
    log "[SCRIPT] Creating virtual environment" "$YELLOW"
    if ! python3 -m venv "$venv_dir"; then
        log "[SCRIPT] Failed to create virtual environment" "$RED"
        exit 1
    fi
fi

# Activate the virtual environment
source "$venv_dir/bin/activate"

# Check if the requirements file has changed and install dependencies if needed
if cmp -s "$requirements_file" "$venv_dir/requirements.txt"; then
    log "[SCRIPT] The requirements are already satisfied" "$GREEN"
else
    log "[SCRIPT] Applying the new requirements" "$YELLOW"
    cp "$requirements_file" "$venv_dir/requirements.txt"
    if ! pip install -r "$requirements_file"; then
        log "[SCRIPT] Failed to install requirements" "$RED"
        deactivate
        exit 1
    fi
fi

# Run the python script
log "[SCRIPT] Running the python script" "$BLUE"
if ! python3 "$file"; then
    log "[SCRIPT] Failed to run the python script" "$RED"
    deactivate
    exit 1
fi

log "[SCRIPT] Script completed successfully" "$GREEN"
deactivate

# Verbose mode
if [ $verbose -eq 1 ]; then
    cat $log_file
fi