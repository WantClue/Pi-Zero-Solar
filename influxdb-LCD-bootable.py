import os
import subprocess

# Run the whoami command
output = subprocess.check_output(["whoami"])

# Decode the output from bytes to string
username = output.decode().strip()

# Store the username in a variable
current_user = username

# Open bashrc file in append mode
with open(os.path.expanduser("~/.bashrc"), "a") as bashrc_file:
    # Append current user to the file
    bashrc_file.write(f"\n# sudo python3 /home/{current_user}/influx_query.py")