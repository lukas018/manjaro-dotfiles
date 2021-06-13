# [[file:README.org::*Imports][Imports:1]]
# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

from pathlib import Path
import json
# Imports:1 ends here

# [[file:README.org::*Variables][Variables:1]]
mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
myTerm = "konsole"                             # My terminal of choice
# Variables:1 ends here

# [[file:README.org::*Keybindings][Keybindings:1]]
keys = [
    # The essentials
    Key([mod], "Return",
        # lazy.spawn(myTerm),
        lazy.spawn(
        r"""emacsclient -c -a 'emacs' --eval '(luklun/run-in-vterm "neofetch")'"""),
        desc='Launches My Terminal'
        ),
    Key([mod], "d",
        lazy.spawn("rofi -show drun"),
        desc='Run Launcher'
        ),
    Key([mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
        ),
    Key([mod], "q",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod, "control"], "q",
        lazy.shutdown(),
        desc='Shutdown Qtile'
        ),
    Key(["control", "shift"], "e",
        lazy.spawn("emacsclient -c -a emacs"),
        desc='Doom Emacs'
        ),
    # Switch focus to specific monitor (out of three)
    Key([mod], "w",
        lazy.to_screen(0),
        desc='Keyboard focus to monitor 1'
        ),
    Key([mod], "e",
        lazy.to_screen(1),
        desc='Keyboard focus to monitor 2'
        ),
    Key([mod], "r",
        lazy.to_screen(2),
        desc='Keyboard focus to monitor 3'
        ),
    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
        ),
    # Treetab controls
    Key([mod, "shift"], "h",
        lazy.layout.move_left(),
        desc='Move up a section in treetab'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.move_right(),
        desc='Move down a section in treetab'
        ),
    # Window controls
    Key([mod], "k",
        lazy.layout.up(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move windows up in current stack'
        ),
    Key([mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),
    # Stack controls
    Key([mod, "shift"], "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
        ),
    Key([mod], "space",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
        ),
    Key([mod, "shift"], "space",
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'
        ),
    # Emacs programs launched using the key chord CTRL+e followed by 'key'
    KeyChord([mod], "e", [
             Key([], "e",
                 lazy.spawn("emacsclient -c -a 'emacs'"),
                 desc='Launch Emacs'
                 ),
             Key([], "b",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"),
                 desc='Launch ibuffer inside Emacs'
                 ),
             Key([], "d",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"),
                 desc='Launch dired inside Emacs'
                 ),
             Key([], "i",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(erc)'"),
                 desc='Launch erc inside Emacs'
                 ),
             Key([], "m",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(mu4e)'"),
                 desc='Launch mu4e inside Emacs'
                 ),
             Key([], "n",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(elfeed)'"),
                 desc='Launch elfeed inside Emacs'
                 ),
             Key([], "s",
                 lazy.spawn("emacsclient -c -a 'emacs' --eval '(eshell)'"),
                 desc='Launch the eshell inside Emacs'
                 ),
             Key([], "v",
                 lazy.spawn(
                     "emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"),
                 desc='Launch vterm inside Emacs'
                 ),
             Key([], "p",
                 lazy.spawn("emacsclient --eval '(emacs-everywhere)'"),
                 desc='Launch emacs-weverywhere on current selection Emacs'
                 ),
             Key([], "c",
                 lazy.spawn(
                     r"""emacsclient -c -a 'emacs' --eval '(luklun/run-in-vterm "ssh -L localhost:53000:cl:22 plugh.foi.se -l luklun")'"""),
                 desc='Loggin to workstation cl'
                 ),
             Key([], "a",
                 lazy.spawn(
                     r"""emacsclient -c -a 'emacs' --eval '(luklun/run-in-vterm "ssh -L localhost:53010:aibks-dlpc-3:22 plugh.foi.se -l luklun")'"""),
                 desc='Loggin to workstation cl'
                 ),
             ]),
    # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord([mod], "p", [
             Key([], "e",
                 lazy.spawn("./dmscripts/dmconf"),
                 desc='Choose a config file to edit'
                 ),
             Key([], "i",
                 lazy.spawn("./dmscripts/dmscrot"),
                 desc='Take screenshots via dmenu'
                 ),
             Key([], "k",
                 lazy.spawn("./dmscripts/dmkill"),
                 desc='Kill processes via dmenu'
                 ),
             Key([], "l",
                 lazy.spawn("./dmscripts/dmlogout"),
                 desc='A logout menu'
                 ),
             Key([], "m",
                 lazy.spawn("./dmscripts/dman"),
                 desc='Search manpages in dmenu'
                 ),
             Key([], "o",
                 lazy.spawn("./dmscripts/dmqute"),
                 desc='Search your qutebrowser bookmarks and quickmarks'
                 ),
             Key([], "r",
                 lazy.spawn("./dmscripts/dmred"),
                 desc='Search reddit via dmenu'
                 ),
             Key([], "s",
                 lazy.spawn("./dmscripts/dmsearch"),
                 desc='Search various search engines via dmenu'
                 ),
             Key([], "p",
                 lazy.spawn("passmenu"),
                 desc='Retrieve passwords with dmenu'
                 )
             ])
]
# Keybindings:1 ends here

# [[file:README.org::*Groups][Groups:1]]
group_names = [("www", {'layout': 'monadtall', 'spawn': 'brave'}),
               ("dev", {'layout': 'monadtall'}),
               ("sys", {'layout': 'monadtall'}),
               ("doc", {'layout': 'monadtall'}),
               ("vbox", {'layout': 'monadtall'}),
               ("chat", {'layout': 'monadtall'}),
               ("mus", {'layout': 'monadtall'}),
               ("vid", {'layout': 'monadtall'}),
               ("gfx", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    # Send current window to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))
# Groups:1 ends here

# [[file:README.org::*Settings For Some Layouts][Settings For Some Layouts:1]]
layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }
# Settings For Some Layouts:1 ends here

# [[file:README.org::*Layouts][Layouts:1]]
layouts = [
    # layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    # layout.Columns(**layout_theme),
    # layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Floating(**layout_theme)
]
# Layouts:1 ends here

# [[file:README.org::*Colors][Colors:1]]
colors = [["#282c34", "#282c34"],  # panel background
          ["#3d3f4b", "#434758"],  # background for current screen tab
          ["#ffffff", "#ffffff"],  # font color for group names
          ["#ff5555", "#ff5555"],  # border line color for current tab
          # border line color for 'other tabs' and color for 'odd widgets'
          ["#74438f", "#74438f"],
          ["#4f76c7", "#4f76c7"],  # color for the 'even widgets'
          ["#e1acff", "#e1acff"],  # window name
          ["#ecbbfb", "#ecbbfb"]]  # backbround for inactive screens
# Colors:1 ends here

# [[file:README.org::*Colors][Colors:2]]
color_file = Path('~/.cache/wal/colors.json').expanduser()
if color_file.is_file():
    color_dict = json.loads(color_file.read_text())['colors']
    colors = [
        [color_dict[color_str],
         color_dict[color_str]]
        for color_str in [
            'color0',  # panel background
            'color8',  # background for current screen tab
            'color15',  # font color for group names
            'color9',  # border line color for current tab
            'color8',  # boder line color for other tabs and color for 'odd widgets'
            'color0',  # color for the 'even widgets'
            'color15',  # window name
            'color8',  # background for inactive screens
        ]]
# Colors:2 ends here

# [[file:README.org::*Prompt][Prompt:1]]
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
# Prompt:1 ends here

# [[file:README.org::*Default Widget Settings][Default Widget Settings:1]]
##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="JetBrains Mono",
    fontsize=12,
    padding=2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()
# Default Widget Settings:1 ends here

# [[file:README.org::*Widgets][Widgets:1]]


def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[2],
            background=colors[0]
        ),
        widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm)}
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[2],
            background=colors[0]
        ),
        widget.GroupBox(
            font="JetBrains Mono Semibold",
            fontsize=11,
            margin_y=4,
            margin_x=0,
            padding_y=5,
            padding_x=4,
            borderwidth=3,
            active=colors[2],
            inactive=colors[7],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[4],
            other_current_screen_border=colors[6],
            other_screen_border=colors[4],
            foreground=colors[2],
            background=colors[0]
        ),
        widget.Prompt(
            prompt=prompt,
            font="JetBrains Mono Semibold",
            padding=10,
            foreground=colors[3],
            background=colors[1]
        ),
        widget.WindowName(
            foreground=colors[6],
            background=colors[0],
            padding=0,
            font="JetBrains Mono Semibold",
            fontsize=0,
        ),
        widget.Systray(
            background=colors[5],
            padding=5
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[0],
            background=colors[0]
        ),
        widget.TextBox(
            text='',
            background=colors[0],
            foreground=colors[4],
            padding=0,
            fontsize=37
        ),
        widget.TextBox(
            text=" Vol:",
            foreground=colors[2],
            background=colors[4],
            padding=0,
            font="JetBrains Mono Semibold"
        ),
        widget.Volume(
            foreground=colors[2],
            background=colors[4],
            padding=5,
            font="JetBrains Mono Semibold"
        ),
        widget.TextBox(
            text='',
            background=colors[4],
            foreground=colors[5],
            padding=0,
            fontsize=37
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[0],
            background=colors[5],
            padding=0,
            scale=0.6
        ),
        widget.CurrentLayout(
            foreground=colors[2],
            background=colors[5],
            padding=5,
            font="JetBrains Mono Semibold"
        ),
        widget.TextBox(
            text='',
            background=colors[5],
            foreground=colors[4],
            padding=0,
            fontsize=37
        ),
        widget.Clock(
            foreground=colors[2],
            background=colors[4],
            format="%A, %B %d - %H:%M ",
            font="JetBrains Mono Semibold"
        ),
    ]
    return widgets_list
# Widgets:1 ends here

# [[file:README.org::*Screens][Screens:1]]


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    # Slicing removes unwanted widgets (systray) on Monitors 1,3
    del widgets_screen1[7:8]
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    # Monitor 2 will display all widgets in widgets_list
    return widgets_screen2


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()
# Screens:1 ends here

# [[file:README.org::*Some Important Functions][Some Important Functions:1]]


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)
# Some Important Functions:1 ends here


# [[file:README.org::*Drag floating windows][Drag floating windows:1]]
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
# Drag floating windows:1 ends here

# [[file:README.org::*Floating windows][Floating windows:1]]
floating_layout = layout.Floating(float_rules=[
    
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Qalculate!'),  # qalculate-gtk
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
# Floating windows:1 ends here

# [[file:README.org::*Startup applications][Startup applications:1]]


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
# Startup applications:1 ends here
