#! /bin/bash


SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

$DIR/loadmap $DIR/x-56.map &

sleep 5

sudo evdev-joystick --e /dev/input/event21 --min 0 --max 65535 --axis 0
sudo evdev-joystick --e /dev/input/event21 --min 0 --max 65535 --axis 1
sudo evdev-joystick --e /dev/input/event21 --min 0 --max 4095 --axis 2
sudo evdev-joystick --e /dev/input/event21 --min 0 --max 1023 --axis 3

