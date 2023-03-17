#! /bin/bash

# This script will install all dependencies for the influxdb connection and asks for user input

# Ask for user input to get the required information
echo "Please enter your InfluxDB server URL (e.g. https://your_influxdb_url:8086):"
read url

echo "Please enter your InfluxDB token:"
read token

echo "Please enter your InfluxDB organization name:"
read org

echo "Please enter your InfluxDB bucket name:"
read bucket

echo "Please enter your measurement name:"
read measurement

echo "Please enter your field name (e.g. value):"
read field

echo "Please enter your time intervall (e.g. -1d for the last 24h | -15m for the last 15min):"
read time

# Create the Python script
cat > influx_query.py << EOF
import time
import curses
import subprocess
from influxdb_client import InfluxDBClient

# Set up the InfluxDB client
bucket = "$bucket"
org = "$org"
token = "$token"
url = "$url"
measurement = "$measurement"
field = "$field"
time = "$time"

# Create a new InfluxDB client instance
client = InfluxDBClient(url=url, token=token, org=org)

# Initialize curses screen
screen = curses.initscr()
curses.curs_set(0)
screen.clear()

# Set font size
curses.start_color()
curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLACK)
curses.cbreak()
screen.keypad(True)
curses.start_color()
curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLACK)
curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_BLACK)
screen.attron(curses.color_pair(2))

try:
    while True:
        # Construct the InfluxDB query to fetch the last record for the specified measurement and field
        query = f'from(bucket:"{bucket}") |> range(start: {time}) |> filter(fn: (r) => r["_measurement"] == "{measurement}" and r["_field"] == "{field}") |> last()'

        # Execute the query and retrieve the last record
        result = client.query_api().query(query=query)
        if result:
            data = result[0].records[0]
            value = data.get_value()
            timestamp = data.get_time()
            screen.clear()
            value_str = f"{value:.2f} WATT"
            figlet_str = subprocess.check_output(["figlet", value_str]).decode("utf-8")
            screen.addstr(0, 0, figlet_str, curses.color_pair(1) | curses.A_BOLD)
            screen.refresh()
        else:
            screen.clear()
            screen.addstr(0, 0, "No data found")
            screen.refresh()
        time.sleep(2)

finally:
    curses.endwin()
EOF

echo "Python script created successfully."
