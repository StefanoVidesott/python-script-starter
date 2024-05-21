# Start Script

This bash script automates the process of setting up a Python virtual environment, installing dependencies from a requirements file, and running a specified Python script. It includes functionalities for verbose logging, specifying custom requirements files, and checking for Python3 installation.

## Features

- Automatically creates and activates a virtual environment.
- Installs dependencies from a `requirements.txt` file.
- Runs a specified Python script.
- Supports custom virtual environment names and requirements files.
- Logs output to both the console and a log file.
- Provides a verbose mode for detailed logging.
- Displays the script version.

## Usage

```bash
./start.sh -f <python_file> [-e <virtual_env_name>] [-r <requirements_file>] [-v] [-V] [-c] [-h]`
```
### Options

    -f <python_file>: Specify the Python script to run. (Required)
    -e <virtual_env_name>: Specify the virtual environment name. (Default: start-script_venv)
    -r <requirements_file>: Specify the requirements file. (Default: requirements.txt)
    -v: Enable verbose mode to print the log file content at the end.
    -V: Display the script version.
    -c: Display credits information.
    -h: Display usage information.

### Examples
Run a Python Script with Default Settings

```bash
./start.sh -f app.py
```

Run a Python Script with a Custom Virtual Environment and Requirements File

```bash
./start.sh -f app.py -e my_custom_env -r my_requirements.txt
```

Run a Python Script in Verbose Mode

```bash
./start.sh -f app.py -v
```

Display the Script Version

```bash
./start.sh -V
```

Display Credit Information

```bash
./start.sh -c
```

Display Usage Information

```bash
./start.sh -h
```

## Script Details
### Error Handling

The script includes error handling for:

    Missing required parameters.
    Missing requirements file.
    Failure to create a virtual environment.
    Failure to install dependencies.
    Failure to run the specified Python script.

### Log Output

Logs are written to both the console and a log file located at /tmp/start_script.log. Verbose mode (-v) prints the log file content to the console at the end of the script execution.

### Environment Deactivation
The script automatically deactivates the virtual environment after the specified Python script completes execution.

### Dependencies
    Python 3.x
    Bash

## License

This project is licensed under the MIT License. See the LICENSE file for details.

# Instructions for Use

1. **Clone the Repository**: Clone the repository to your local machine.
2. **Make the Script Executable**: Ensure the script has executable permissions.
```bash
chmod +x start.sh
```
3. **Move the script in your project directory**: make the python application accessible to the script

4. **Run the Script**: Use the provided usage examples to run the script according to your needs.

## Contributing

Feel free to open issues or submit pull requests for improvements and bug fixes.