# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, widget
from libqtile.layout.max import Max
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Match, ScratchPad, DropDown
from libqtile.lazy import lazy

import psutil
import os

BAT = psutil.sensors_battery() is not None
HOME = os.getenv("HOME", default="/home/mirko")

if BAT:
    KEYS = "es"
else:
    KEYS = "latam"

autostart = [
    "setxkbmap "+KEYS,
    "feh --bg-scale "+HOME+"/.config/qtile/Fondo.jpg  --no-xinerama",
]

for x in autostart:
    os.system(x)

MOD = "mod4"
terminal = "alacritty"  #guess_terminal()
if BAT:
    terminal = terminal+" -o font.size=7.5"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key([MOD], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([MOD, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([MOD, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([MOD, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [MOD, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([MOD], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([MOD], "r", lazy.spawn("rofi -show drun"), desc="Program Launcher"),
    Key([MOD], "p", lazy.spawn(HOME+"/.config/qtile/power.sh"), desc="Program Launcher"),
    Key([MOD, "shift"], "w", lazy.spawn(HOME+"/.config/qtile/wifi.sh"), desc="Program Launcher"),
    Key(["mod1"], "Tab", lazy.spawn("rofi -show window"), desc="Move between windows"),
    Key([MOD, "shift"], "s", lazy.spawn("flameshot gui"), desc="Screeshots"),

    Key([], "XF86AudioMute",        lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 1%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 1%+ unmute")),

    Key([MOD, "shift"], "c", lazy.spawn(terminal+" -e calcurse"), desc="Launch calcurse"),
    Key([MOD, "shift"], "m", lazy.spawn(terminal+" -e "+HOME+"/.config/qtile/neomutt.sh"), desc="Launch neomutt"),
    Key([MOD, "shift"], "f", lazy.spawn(terminal+" -e ranger"), desc="Launch ranger"),
    Key([MOD, "shift"], "g", lazy.spawn(terminal+" -e btop"), desc="Launch btop"),
    Key([MOD, "shift"], "d", lazy.spawn(terminal+" --config-file "+HOME+"/.config/alacritty/alacritty_Iosevka.yml -e flash"), desc="Launch btop"),
    Key([MOD, "shift"], "v", lazy.spawn("tabbed -c vimb -e"), desc="Launch vimb"),
    Key([MOD, "shift"], "a", lazy.spawn("pavucontrol"), desc="Launch audio control"),

    Key([MOD], "t", lazy.window.toggle_floating(), desc='Toggle floating')
]

if BAT:
    keys.extend([
        Key([MOD], "F2", lazy.spawn("/home/mirko/.config/qtile/toggle_touchpad.fish")),
        ])

if BAT:
    HEIGHT = 0.72
    Y = 0.14
else:
    HEIGHT = 0.5
    Y = 0.25

__groups = {
    1: Group(""),
    2: Group("爵",matches=[Match(wm_class=["Brave"  ])]),
    3: Group("", matches=[Match(wm_class=["kicad"    ])]),
    4: Group("", matches=[Match(wm_class=["mplab_ide"])]),
    0: Group(""),
    5: ScratchPad("ScratchPad", [
        DropDown(
            "term",
            terminal,
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "calcurse",
            terminal+" -e calcurse",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "neomutt",
            terminal+" -e "+HOME+"/.config/qtile/neomutt.sh",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "ranger",
            terminal+" -e ranger",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "btop",
            terminal+" -e btop",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "vimb",
            "vimb",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "qalculate",
            "qalculate-gtk",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "flash",
            terminal+" -e flash",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            "pavucontrol",
            "pavucontrol",
            height = HEIGHT,
            width = 0.8,
            x = 0.1,
            y = Y,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
    ]),
} 

groups = [__groups[i] for i in __groups]

def get_group_key(name):
    return [k for k, g in __groups.items() if g.name == name][0]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [MOD],
                str(get_group_key(i.name)),
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [MOD, "shift"],
                str(get_group_key(i.name)),
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([MOD, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

keys.extend([
    Key([MOD], "s",
        lazy.group["ScratchPad"].dropdown_toggle("term")
    ),
    Key([MOD], "c",
        lazy.group["ScratchPad"].dropdown_toggle("calcurse")
    ),
    Key([MOD], "m",
        lazy.group["ScratchPad"].dropdown_toggle("neomutt")
    ),
    Key([MOD], "f",
        lazy.group["ScratchPad"].dropdown_toggle("ranger")
    ),
    Key([MOD], "g",
        lazy.group["ScratchPad"].dropdown_toggle("btop")
    ),
    Key([MOD], "v",
        lazy.group["ScratchPad"].dropdown_toggle("vimb")
    ),
    Key([MOD], "q",
        lazy.group["ScratchPad"].dropdown_toggle("qalculate")
    ),
    Key([MOD], "d",
        lazy.group["ScratchPad"].dropdown_toggle("flash")
    ),
    Key([MOD], "a",
        lazy.group["ScratchPad"].dropdown_toggle("pavucontrol")
    ),
])

layouts = [
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    Columns(border_focus="#a9ded7", border_normal="#4f6b67", border_width=4, border_on_single=True, margin=4),
    Max(border_focus="#a9ded7", border_width=4, margin=4),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),.
]

BBT ="BigBlue_Terminal_437TT Nerd Font Mono"

widget_defaults = dict(
    #font="Iosevka",
    font=os.getenv("FONT",default="BigBlue_Terminal_437TT Nerd Font Mono"),
    fontsize=15,
    padding=6,
)
extension_defaults = widget_defaults.copy()

if BAT:
    screens = [
        Screen(
            bottom=bar.Bar(
                [
                    widget.GroupBox(this_current_screen_border='a9ded7',fontsize = 25,font=BBT),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            "launch": ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    widget.CheckUpdates(colour_have_updates='00ff00'),
                    #widget.CryptoTicker(currency='USD', crypto = 'ADA'),
                    widget.TextBox(text="", fontsize = 25, padding = 0,font=BBT),
                    widget.Net(format=":{down} ↓↑ {up}"),
                    widget.Battery(
                        discharge_char='',
                        charge_char='',
                        empty_char='',
                        full_char='',
                        format=' {char}: {percent:2.0%}'),
                    widget.TextBox(text=" 墳", fontsize = 25, padding = 0,font=BBT),
                    widget.Volume(fmt=': {}'),
                    widget.Systray(),
                    widget.Clock(format=" %H:%M %a %d/%m/%Y %p"),
                ],
                24,
                opacity=0.7
            ),
        ),
        Screen(),
    ]
else:
    screens = [
        Screen(
            bottom=bar.Bar(
                [
                    widget.GroupBox(this_current_screen_border='a9ded7',fontsize = 25,font=BBT),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Chord(
                        chords_colors={
                            "launch": ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),
                    widget.CheckUpdates(colour_have_updates='00ff00'),
                    #widget.CryptoTicker(currency='USD', crypto = 'ADA'),
                    widget.TextBox(text="", fontsize = 25, padding = 0,font=BBT),
                    widget.Net(format=":{down} ↓↑ {up}"),
                    widget.TextBox(text=" 墳", fontsize = 25, padding = 0,font=BBT),
                    widget.Volume(fmt=': {}'),
                    widget.Systray(),
                    widget.Clock(format=" %H:%M %a %d/%m/%Y %p"),
                ],
                24,
                opacity=0.7
            ),
        ),
        Screen(),
    ]


# Drag floating layouts.
mouse = [
    Drag([MOD], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus="#a9ded7",
    border_normal="#4f6b67",
    border_width=4,
    border_on_single=True,
    margin=4,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
