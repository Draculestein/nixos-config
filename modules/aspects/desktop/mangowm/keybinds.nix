# Mango key bindings — mirrors modules/aspects/desktop/niri/keybinds.kdl
# https://mangowm.github.io/docs/bindings/keys
#
# Mango has no column-based tiling model, hotkey overlay, or per-app
# shortcut-inhibit toggle like niri, so a handful of niri binds have no
# clean equivalent and are intentionally left out (see comments below):
#   - Mod+Shift+Slash (show-hotkey-overlay)
#   - Mod+Escape (toggle-keyboard-shortcuts-inhibit)
#   - Alt+Mod+V (switch-focus-between-floating-and-tiling)
#   - Mod+W (toggle-column-tabbed-display)
#   - Mod+Ctrl+R / Mod+Shift+Equal / Mod+Shift+Minus (per-window height presets)
#
# Screenshots use grim+slurp (niri has screenshotting built in; mango does
# not), so `grim`/`slurp` must be in home.packages alongside the existing
# `wl-clipboard`/`satty` used for the annotate bind.
{ den, lib, ... }:
{
  den.aspects.mangowm = {
    homeManager = { osConfig, ... }:
      let
        hasAsusKbdBacklight = osConfig.networking.hostName == "AlbertProP16";
      in
      {
        wayland.windowManager.mango.settings = {
          bind = [
            "SUPER,t,spawn,kitty"
            "SUPER,b,spawn,brave"
            "SUPER,e,spawn,nautilus"
            "SUPER,c,spawn,code"
            "SUPER,l,spawn,loginctl lock-session"

            "SUPER,space,spawn,noctalia msg panel-toggle launcher"
            "SUPER,s,spawn,noctalia msg settings-toggle"
            "SUPER,q,killclient"
            "SUPER,Tab,toggleoverview"

            "CTRL+ALT,Delete,quit"

            # Focus
            "SUPER,Left,focusdir,left"
            "SUPER,Right,focusdir,right"
            "SUPER,Up,focusdir,up"
            "SUPER,Down,focusdir,down"

            # Move
            "SUPER+SHIFT,Left,exchange_client,left"
            "SUPER+SHIFT,Right,exchange_client,right"
            "SUPER+SHIFT,Up,exchange_client,up"
            "SUPER+SHIFT,Down,exchange_client,down"

            # Column management — approximated with scroller_stack, which only
            # applies in the scroller layout (no-op on tile/other layouts). Mango
            # has no separate consume-vs-expel dispatcher, so bracket and
            # comma/period both toggle stack membership toward the same direction.
            "SUPER,bracketleft,scroller_stack,left"
            "SUPER,bracketright,scroller_stack,right"
            "SUPER,comma,scroller_stack,left"
            "SUPER,period,scroller_stack,right"

            # Sizing
            "SUPER,r,switch_proportion_preset"
            "SUPER,f,togglemaximizescreen"
            # niri spawns nfsm-cli (a niri-only floating scratchpad manager); mango's
            # native scratchpad is the closest built-in equivalent.
            "SUPER+SHIFT,f,toggle_scratchpad"

            "SUPER,equal,setmfact,+0.05"
            "SUPER,minus,setmfact,-0.05"

            # Floating
            "SUPER,v,spawn,noctalia msg panel-toggle clipboard"
            "SUPER+SHIFT,v,togglefloating"

            # Screenshots
            "SUPER+SHIFT,s,spawn_shell,mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" -c - | tee ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy"
            "SUPER+SHIFT,a,spawn_shell,wl-paste | satty -f -"
            "CTRL+SUPER+SHIFT,s,spawn_shell,mkdir -p ~/Pictures/Screenshots && grim -c - | tee ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy"
            "ALT+SUPER+SHIFT,s,spawn_shell,mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" -c ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"

            # Workspaces (mango tags) — focus
            "SUPER,1,view,1,0"
            "SUPER,2,view,2,0"
            "SUPER,3,view,3,0"
            "SUPER,4,view,4,0"
            "SUPER,5,view,5,0"
            "SUPER,6,view,6,0"
            "SUPER,7,view,7,0"
            "SUPER,8,view,8,0"
            "SUPER,9,view,9,0"

            # Workspaces — move window
            "SUPER+SHIFT,1,tag,1,0"
            "SUPER+SHIFT,2,tag,2,0"
            "SUPER+SHIFT,3,tag,3,0"
            "SUPER+SHIFT,4,tag,4,0"
            "SUPER+SHIFT,5,tag,5,0"
            "SUPER+SHIFT,6,tag,6,0"
            "SUPER+SHIFT,7,tag,7,0"
            "SUPER+SHIFT,8,tag,8,0"
            "SUPER+SHIFT,9,tag,9,0"

            # Workspaces — scroll navigation. Mango tags are a linear sequence, not
            # spatial rows, so niri's up/down is mapped to previous/next tag.
            "SUPER+CTRL,Up,viewtoleft_have_client"
            "SUPER+CTRL,Down,viewtoright_have_client"
            "SUPER+SHIFT+CTRL,Up,tagtoleft"
            "SUPER+SHIFT+CTRL,Down,tagtoright"
          ];

          # allow-when-locked binds (niri's `allow-when-locked=true`)
          bindl = [
            # Audio
            "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1.1 @DEFAULT_AUDIO_SINK@ 5%+"
            "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume -l 0 @DEFAULT_AUDIO_SINK@ 5%-"
            "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

            # Brightness
            "NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up"
            "NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down"
          ]
          # Keyboard backlight (ASUS only)
          ++ lib.optionals hasAsusKbdBacklight [
            "NONE,XF86KbdBrightnessUp,spawn,brightnessctl -d asus::kbd_backlight set +1"
            "NONE,XF86KbdBrightnessDown,spawn,brightnessctl -d asus::kbd_backlight set 1-"
            "NONE,XF86KbdLightOnOff,spawn,cycle-kbd-backlight"
          ];

          # Mouse wheel (niri's cooldown-ms=150 -> global axis_bind_apply_timeout below)
          axisbind = [
            "SUPER,RIGHT,focusdir,right"
            "SUPER,LEFT,focusdir,left"
            "SUPER,UP,focusdir,up"
            "SUPER,DOWN,focusdir,down"
            "SUPER+SHIFT,UP,focusdir,left"
            "SUPER+SHIFT,DOWN,focusdir,right"
          ];

          axis_bind_apply_timeout = 150;
        };
      };
  };
}
