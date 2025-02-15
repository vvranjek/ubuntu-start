
mkdir -p ~/Develop/esp
cd ~/Develop/esp

git clone -b v5.4 --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
./install.sh esp32


# Set the path to the .profile file
PROFILE_FILE=$HOME/.profile

# Set the path to the export.sh file
EXPORT_FILE=$HOME/esp/esp-idf/export.sh

# Set the line to add to the .profile file
LINE="source $HOME/esp/esp-idf/export.sh"

# Check if the export.sh file exists
if [ ! -f "$EXPORT_FILE" ]; then
  # If the file doesn't exist, print an error message and exit
  echo "Error: $EXPORT_FILE file does not exist"
  exit 1
fi

# Check if the line already exists in the .profile file
if ! grep -q "$LINE" "$PROFILE_FILE"; then
  # If the line doesn't exist, add it to the .profile file
  echo "$LINE" >> "$PROFILE_FILE"
  echo "Added line to .profile file"
else
  # If the line already exists, print a message indicating that
  echo "Line already exists in .profile file"
fi
