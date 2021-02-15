# i3lock-script
A small wrapper script around i3lock-color
I initially based this around [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) as I liked their visuals, but I did not agree with their implementation.

# Requirements
 - bash
 - git
 - imagemagick
 - i3lock-color

# The idea
This script reads the config and generates a script and background file in `~/.cache/i3lock-script`. The script is an executable file (think `.fehbg`) and the background file is a blurred cached version of the origional file with a rectangle drawn on it.

# Installing
Copy the following files to somewhere in your `$PATH`:
 - i3lock-script
 - i3lock-script-update
 - i3lock-script-static.sh
 - i3lock-script-defaults

Copy the `colors.i3lock` to `~/.config/wal/templates/` if you want to use [pywal](https://github.com/dylanaraps/pywal).

Copy `i3lock-script-defaults` to `~/.config/i3lock-script/config` and modify the values to your needs.

## Installing with your .dotfiles
I would personally add this repo as a submodule and add a symlink to the executables.

# Configuring
As I was somewhat too lazy to build a full fledges config parsing thing, I used git's config parsing (since almost everybody has git). The following options as shown in the table below can be configured. If a value is missing from the user's config file, the default value is used instead.

Additionally it's possible to reference other config fields. To do this simply use `$group.field` for the value you want to reference. If you, for example, want the same font size for your date as for the time you can set the date's size to: `$time.size`.

Lastly if you want to see how I have my configuration, look [here](https://github.com/tosti007/dotfiles/blob/master/user/i3lock-script/.config/i3lock-script/config)

| Group   | Field            | Format     | Description |
|---------|------------------|------------|-------------|
| general | use-pywal        | bool       | Set wether config values of pywal should also be checked. It will search `~/.cache/wal/colors.i3lock` for these values. |
| ^       | arguments        | string     | Default arguments passed along i3lock-color. Check their documentation for the options. |
| screen  | background-color | rrggbb[aa] | The default background color (e.g. when no image is given or it's too small). |
| ^       | background-image | path       | The path to the background image to use. |
| box     | background-color | rrggbb[aa] | The color to fill the rectangle with. |
| ^       | border-radius    | int        | The radius for the rectangle corners. |
| ^       | margin           | int        | The margin between the window and the rectangle in pixels. |
| ^       | padding          | int        | The padding between the date/time and the rectangle edges. |
| ring    | width            | int        | The ring width. |
| ^       | color            | rrggbb[aa] | The default ring color. |
| ^       | color-highlight  | rrggbb[aa] | The highlight color for the ring highlights. |
| ^       | color-wrong      | rrggbb[aa] | The color for the ring center when a wrong password is given. |
| ^       | color-remove     | rrggbb[aa] | The color for the ring highlights when BACKSPACE is pressed. |
| text    | font             | text       | Font to use for time and date. |
| ^       | color            | rrggbb[aa] | Color to use for text. |
| ^       | spacing          | int        | The distance between the date and time. |
| time    | format           | timeformat | Format to use for printing the time, see `i3lock --help` for more info. |
| ^       | width            | int        | Some constant value to multiply the width of the printed text with. Unfortunatly it's not possible for me to know the width of the printed text during file generating, thus we need some magical constant that helps us estimate that value. |
| ^       | size             | int        | Font size. |
| date    | format           | dateformat | Format to use for printing the date, see `i3lock --help` for more info. |
| ^       | width            | int        | Some constant value to multiply the width of the printed text with. Unfortunatly it's not possible for me to know the width of the printed text during file generating, thus we need some magical constant that helps us estimate that value. |
| ^       | size             | int        | Font size. |

