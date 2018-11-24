# Lunch Focus Min

To launch an application or to show its window if already launched or to minimize if it is focused

1) Install [wmctrl](http://apt.ubuntu.com/p/wmctrl) & [xdotool](http://apt.ubuntu.com/p/xdotool)

    ```sh
        sudo apt-get install wmctrl xdotool
    ```

2) Make a script:

    - Copy above file(`launch_focus_min.sh`) into  `/usr/local/bin`.

    - Make it executable: `sudo chmod +x /usr/local/bin/launch_focus_min.sh`

3) Make your keyboard shortcut:

    - Open your keyboard settings and create a custom shortcut with the command:

        ```sh
            /usr/local/bin/launch_focus_min.sh code
        ```