{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.config = {
    modifier = "Mod4";
    modes = {};

    window = {
      border = 3;
#      hideEdgeBorders = "both";
commands = [
      # Force use border on all windows
      { command = "border pixel 3"; criteria = { title = ".*"; }; }
    ];
  };
  gaps = {
    inner = 2;
    outer = 3;
    bottom = 2;
    horizontal = 5;
    vertical = 5;
  };

  output = {
    "HDMI-A-1" = {
      bg = "/home/pandy/Pictures/20250624_160813.jpg fill";
      mode = "1920x1080";
      pos = "1080 700";
      allow_tearing = "yes";
    };
    "DP-3" = {
      bg = "/home/pandy/Pictures/wallpaper/wallhaven-lmq522.jpg fill";
      pos = "0 0";
      transform = "270";
    };
    "DP-2" = {
      bg = "/home/pandy/Pictures/20250624_160756.jpg fill";
      mode = "1920x1080@144Hz";
      pos = "3000 100";
    };
  };

#  startup =
#    let
#      lockScript = pkgs.writeShellScriptBin "sway-custom-lock" ''
#        ${pkgs.swaylock-effects}/bin/swaylock \
#        -f -i /usr/share/wallpaper.png -s fill \
#        --clock \
#        --effect-vignette 0.5:0.5 \
#        --effect-blur 7x5 \
#        --indicator \
#        --indicator-radius 100 \
#        --indicator-thickness 7 \
#        --ring-color 455a64 \
#        --ring-wrong-color c92c1e \
#        --ring-ver-color 5046bf \
#        --ring-clear-color 46bf50 \
#        --key-hl-color be5046 \
#        --text-color ffc107 \
#        --text-clear-color ffc107 \
#        --text-ver-color ffc107 \
#        --text-wrong-color ffc107 \
#        --line-uses-ring \
#        --inside-color 00000088 \
#        --inside-clear-color 00000088 \
#        --inside-ver-color 00000088 \
#        --inside-wrong-color 00000088 \
#        --separator-color 00000000 \
#        --fade-in 0.2
#      '';
#      lock = "${lockScript}/bin/sway-custom-lock";
#    in
#    [
#      { command = "mako"; }
#      {
#        command = ''
#          swayidle \
#            lock          '${lock}' \
#            timeout   300 '${lock}' \
#            resume 'swaymsg "output * dpms on"' \
#            before-sleep  '${lock}'
#        '';
#      }
#    ];

#  input = {
#     "*" = {
#        scroll_method = "on_button_down";
#        natural_scroll = "enabled";
#        tap = "enabled";
#        middle_emulation = "enabled";
#        xkb_layout = "us,ru";
#        xkb_options = "ctrl:nocaps,grp:toggle,grp_led:caps";
#     };
#  };

  ## template = { border = "#"; background = "#"; text = "#"; indicator = "#"; childBorder = "#"; };
  ## Colors from https://github.com/unix121/i3wm-themer/blob/master/themes/001.yml
  colors = {
#    background ="#1E272B";

focused =         { border = "#5fd7ff"; background = "#5fd7ff"; text = "#302d30"; indicator = "#0000ff"; childBorder = "#5fd7ff";};
unfocused =       { border = "#004557"; background = "#004557"; text = "#a1c9cc"; indicator = "#0000ff"; childBorder = "#004557";};
focusedInactive = { border = "#004557"; background = "#004557"; text = "#a1c9cc"; indicator = "#0000ff"; childBorder = "#004557";};
urgent =          { border = "#E53935"; background = "#E53935"; text = "#302d30"; indicator = "#0000ff"; childBorder = "#E53935";};
placeholder =     { border = "#EAD49B"; background = "#1E272B"; text = "#302d30"; indicator = "#78824B"; childBorder = "#EAD49B";};
  };

  bindkeysToCode = true;
  keybindings =
    let
      mod = "Mod4";
      mod1 = "Mod1";
      mod2 = "Mod2";
    in {
      "${mod}+1"         = "workspace number 1";
      "${mod}+2"         = "workspace number 2";
      "${mod}+3"         = "workspace number 3";
      "${mod}+4"         = "workspace number 4";
      "${mod}+5"         = "workspace number 5";
      "${mod}+6"         = "workspace number 6";
      "${mod}+7"         = "workspace number 7";
      "${mod}+8"         = "workspace number 8";
      "${mod}+9"         = "workspace number 9";
      "${mod}+0"         = "workspace number 10";
      "${mod}+${mod1}+1" = "workspace number 11";
      "${mod}+${mod1}+2" = "workspace number 12";
      "${mod}+${mod1}+3" = "workspace number 13";
      "${mod}+${mod1}+4" = "workspace number 14";
      "${mod}+${mod1}+5" = "workspace number 15";
      "${mod}+${mod1}+6" = "workspace number 16";
      "${mod}+${mod1}+7" = "workspace number 17";
      "${mod}+${mod1}+8" = "workspace number 18";
      "${mod}+${mod1}+9" = "workspace number 19";
      "${mod}+${mod1}+0" = "workspace number 20";

      "${mod}+Shift+1"         = "move container to workspace number 1";
      "${mod}+Shift+2"         = "move container to workspace number 2";
      "${mod}+Shift+3"         = "move container to workspace number 3";
      "${mod}+Shift+4"         = "move container to workspace number 4";
      "${mod}+Shift+5"         = "move container to workspace number 5";
      "${mod}+Shift+6"         = "move container to workspace number 6";
      "${mod}+Shift+7"         = "move container to workspace number 7";
      "${mod}+Shift+8"         = "move container to workspace number 8";
      "${mod}+Shift+9"         = "move container to workspace number 9";
      "${mod}+Shift+0"         = "move container to workspace number 10";
      "${mod}+${mod1}+Shift+1" = "move container to workspace number 11";
      "${mod}+${mod1}+Shift+2" = "move container to workspace number 12";
      "${mod}+${mod1}+Shift+3" = "move container to workspace number 13";
      "${mod}+${mod1}+Shift+4" = "move container to workspace number 14";
      "${mod}+${mod1}+Shift+5" = "move container to workspace number 15";
      "${mod}+${mod1}+Shift+6" = "move container to workspace number 16";
      "${mod}+${mod1}+Shift+7" = "move container to workspace number 17";
      "${mod}+${mod1}+Shift+8" = "move container to workspace number 18";
      "${mod}+${mod1}+Shift+9" = "move container to workspace number 19";
      "${mod}+${mod1}+Shift+0" = "move container to workspace number 20";

      "${mod}+Tab" = "workspace back_and_forth";
      "${mod}+q" = "kill";
      "${mod}+Shift+q" = "kill";
      "${mod}+Return" = "exec alacritty -e tmux";
      "${mod}+Shift+Return" = "exec alacritty";
      "${mod}+d" = "exec wofi --show run -H 300 -W 600";
      "${mod}+Escape" = "exec swaylock -i /home/pandy/Pictures/wallpaper/i90bLZFzoz1Ho.png";
      "${mod}+Shift+x" = "exec swaylock -i /home/pandy/Pictures/wallpaper/i90bLZFzoz1Ho.png";
      "${mod}+Shift+e" = "exec swaynag -t warning -m 'Do you want to exit sway?' -b 'Yes' 'swaymsg exit'";

      "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
      "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
      "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

      "${mod}+p" = "exec arandr";

      "${mod}+space" = "focus mode_toggle";
      "${mod}+Shift+space" = "floating toggle";

      "${mod}+s" = "layout stacking";
      "${mod}+w" = "layout tabbed";
      "${mod}+e" = "layout toggle split";
      "${mod}+v" = "split v";

      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";

      "${mod}+Ctrl+Shift+Left" = "resize shrink width 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+Down" = "resize grow height 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+Up" = "resize shrink height 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+Right" = "resize grow width 8 px or 8 ppt";

      "${mod}+h" = "focus left";
      "${mod}+j" = "focus down";
      "${mod}+k" = "focus up";
      "${mod}+l" = "focus right";

      "${mod}+Shift+h" = "move left";
      "${mod}+Shift+j" = "move down";
      "${mod}+Shift+k" = "move up";
      "${mod}+Shift+l" = "move right";

      "${mod}+Ctrl+Shift+h" = "resize shrink width 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+j" = "resize grow height 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+k" = "resize shrink height 8 px or 8 ppt";
      "${mod}+Ctrl+Shift+l" = "resize grow width 8 px or 8 ppt";

      "${mod}+Shift+plus" = "gaps inner current plus 6";
      "${mod}+Shift+minus" = "gaps inner current minus 6";

      "${mod}+f" = "fullscreen toggle";
    };
    workspaceOutputAssign = [
      { workspace = "1"; output = "DP-3"; }
      { workspace = "10"; output = "DP-3"; }
      { workspace = "11"; output = "DP-3"; }
      { workspace = "12"; output = "DP-3"; }
      { workspace = "19"; output = "DP-3"; }
      { workspace = "20"; output = "DP-3"; }
      { workspace = "2"; output = "HDMI-A-1"; }
      { workspace = "4"; output = "HDMI-A-1"; }
      { workspace = "7"; output = "HDMI-A-1"; }
      { workspace = "9"; output = "HDMI-A-1"; }
      { workspace = "3"; output = "DP-2"; }
      { workspace = "5"; output = "DP-2"; }
      { workspace = "6"; output = "DP-2"; }
      { workspace = "8"; output = "DP-2"; }
    ];
    bars = [];
  };
  wayland.windowManager.sway.extraConfig = ''
     exec --no-startup-id nm-applet
     exec --no-startup-id blueman-applet
     exec --no-startup-id waybar -c ~/.config/waybar/configsway & waybar -c ~/.config/waybar/configswaysub
  '';
  wayland.windowManager.sway.checkConfig = false;
}
