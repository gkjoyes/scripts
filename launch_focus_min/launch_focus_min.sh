#!/bin/bash
#
# This script does following:
# - Launch an app if it isn't launched yet,
# - Focus the app if it is launched but not focused,
# - Minimize the app if it is focused.


# First let's check if the needed tools are installed:
tool1=$(which xdotool)
tool2=$(which wmctrl)

# Install xdotool
if [ -z $tool1 ]; then
  echo "Xdotool is needed, do you want to install it now? [Y/n]"
  read a
  if [[ $a == "Y" || $a == "y" || $a = "" ]]; then
    sudo apt-get install xdotool
  else
    echo "Exiting then..."
    exit 1
  fi
fi

# Install wmctrl
if [ -z $tool2 ]; then
  echo "Wmctrl is needed, do you want to install it now? [Y/n]"
  read a
  if [[ $a == "Y" || $a == "y" || $a = "" ]]; then
    sudo apt-get install wmctrl
  else
    echo "Exiting then..."
    exit 1
  fi
fi

# Check if we're trying to use an app that needs a special process name.
app=$1
if [[ $app == google-chrome ]]; then
  process_name=chrome
elif [[ $app == code ]]; then
  process_name=usr/share/code/code
elif [[ $app == atom ]]; then
  process_name=usr/share/atom/atom
elif [[ $app == spotify ]]; then
  process_name=usr/share/spotify/spotify
elif [[ $app == pac ]]; then
  process_name=usr/bin/pac
elif [[ $app == subl ]]; then
  process_name=opt/sublime_text/sublime_text
elif [[ $app == smerge ]]; then
  process_name=opt/sublime_merge/sublime_merge
else
  process_name=$app
fi

# Try to get process-id of the app by its name.
pid=$(pgrep -f -o $process_name)

if [ -z $pid ]; then
  # If it isn't launched, then launch.
  $app
else
  
  # If it is launched then check if it is focused.
  foc=$(xdotool getactivewindow getwindowpid)

  if [[ $pid == $foc ]]; then

    # If it is focused, then minimize.
    xdotool getactivewindow windowminimize
  else

    # If it isn't focused then get focus.
    wmctrl -ia $(wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}') 
    # wmctrl -x -R $app
  fi
fi

exit 0
