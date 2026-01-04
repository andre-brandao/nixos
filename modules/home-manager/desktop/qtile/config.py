from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
# from qtile_extras.widget.decorations import BorderDecoration
# from qtile_extras.widget.decorations import RectDecoration

mod = "mod4"
terminal = guess_terminal()
font_name = "Intel One Mono"
font_size = 15
padding_size = 12   # Define padding for widgets

# myColors = {
#     "foreground": "#f9f6e2",
#     "background": "#1d1d1d",
#     "primary": "#d75f5f",
#     "secondary": "#8f3d3d",
#     "tertiary": "#4c566a",
# }
myColors = {
    # Light grey for text, providing good contrast on dark backgrounds
    "foreground": "#e1e1e6",
    # Dark grey background, giving a modern and less stark appearance
    "background": "#282a36",
    # Bright pink, stands out for important elements like active window borders
    "primary": "#ff79c6",
    "secondary": "#bd93f9",   # Soft purple, for less critical but still significant elements
    # Vivid green, for accents and highlighting important UI elements
    "tertiary": "#50fa7b",
}

battery_colors = {
    "high": myColors['tertiary'],
    "medium": "#ffcc00",
    "low": "#ff0000",
}

widget_defaults = {
    "font": font_name,
    "fontsize": font_size,
    "padding": padding_size,
    "foreground": myColors['foreground'],
    "background": myColors['background']
}
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),



    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),


    Key([mod, "control"], "Return", lazy.spawn(
        "rofi -show drun"), desc="Launch Rofi"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(
                func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": myColors['primary'],
    "border_normal": myColors['secondary'],
}
layouts = [
    layout.Columns(**layout_theme),
    layout.Max(),
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
    # layout.Zoomy(),
]


extension_defaults = widget_defaults.copy()

# mycolors = dict(
#     foreground="#f9p6e2",
#     background="#1d1d1d",
#     primary="",
#     secondary="",
#     tertiary=""
# )

screens = [
    Screen(
        bottom=bar.Bar(
            [
                # widget.Sep(
                #     linewidth=1,
                #     padding=5,
                #     foreground="#4c566a",
                #     background="#2e3440"
                # ),

                widget.CurrentLayoutIcon(
                    padding=4,
                    scale=0.7,
                    # Example of overriding default
                    foreground=myColors['tertiary'],
                    background=myColors['background']
                ),
                widget.CurrentLayout(
                    foreground=myColors['foreground'],
                    background=myColors['background'],
                ),
                widget.GroupBox(
                    # fontsize=12,
                    # margin_y=2,
                    margin_x=3,
                    # padding_y=2,
                    # padding_x=3,
                    # borderwidth=2,
                    # disable_drag=True,
                    # active="#4c566a",

                    # # inactive="#2e3440",
                    # rounded=False,
                    highlight_method="line",
                    # this_current_screen_border="#d8dee9",
                    # foreground="#4c566a",
                    # background="#2e3440"
                    active=myColors['tertiary'],
                    inactive=myColors['secondary'],
                    this_current_screen_border=myColors['primary'],
                    foreground=myColors['foreground'],
                    background=myColors['background']
                ),
                widget.Prompt(
                    foreground=myColors['primary'],
                    background=myColors['background'],
                ),
                widget.WindowName(
                    foreground=myColors['tertiary'],
                    background=myColors['background']
                ),
                widget.KeyboardLayout(
                    foreground=myColors['primary'],
                    background=myColors['background'],
                ),

                # widget.WidgetBox(
                #     text_closed=' Show Widgets',  # Text displayed when WidgetBox is closed
                #     text_open=' Hide Widgets',    # Text displayed when WidgetBox is open
                #     foreground=myColors['foreground'],
                #     background=myColors['background'],
                #     font='sans',
                #     fontsize=14,
                #     widgets=[
                widget.DF(
                    visible_on_warn=False,
                    # fontsize=12,
                    foreground=myColors['primary'],
                    background=myColors['background'],
                    format=' {f}GB'
                ),
                widget.Memory(
                    # fontsize=12,
                    foreground=myColors['secondary'],
                    background=myColors['background'],
                    format='󰍛 {MemPercent}%'
                ),
                widget.Net(
                    foreground=myColors['tertiary'],
                    background=myColors['background'],
                    format='net: {down:5} ↓↑ {up:5}',
                ),
                # ],
                # ),

                # widget.Chord(
                #     chords_colors={
                #         "launch": ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn",
                #              foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(
                    format="%d-%m-%Y %a %I:%M %p",
                    foreground=myColors['foreground'],
                    background=myColors['background'],
                ),
                # widget.QuickExit(),
                # Setup Battery widget
                widget.Battery(
                    # Default color, will be dynamically changed
                    foreground=battery_colors['high'],
                    background=myColors['background'],
                    format='{char} {percent:2.0%}',
                    update_interval=60,
                    low_percentage=0.20,
                    low_foreground=battery_colors['low'],
                    notify_below=20,
                ),
                widget.BatteryIcon(
                    foreground=myColors['tertiary'],
                    background=myColors['background']
                ),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
wmname = "LG3D"
