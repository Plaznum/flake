{ config, lib, pkgs, ... }:
let
  color = "#875faf";
# Tokyonight Moon theme colors
  thm_bg="#222436";
  thm_fg="#c8d3f5";
  thm_cyan="#86e1fc";
  thm_black="#1b1d2b";
  thm_gray="#3a3f5a";
  thm_magenta="#c099ff";
  thm_pink="#ff757f";
  thm_red="#ff757f";
  thm_green="#c3e88d";
  thm_yellow="#ffc777";
  thm_blue="#82aaff";
  thm_orange="#ff9e64";
  thm_black4="#444a73";
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    focusEvents = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-s";
    terminal = "tmux-256color";
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind P paste-buffer
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel
      set -g pane-active-border-style 'fg=${color}'
      set -g status-style 'fg=${color}'
      set -g status-position 'top'
      set-option -g default-command bash
      setw -g pane-base-index 1
      set -g pane-base-index 1
      set-option -sa terminal-overrides ',*:RGB'
      set -g status-position 'top'
      set-option -g default-command bash

      # Status bar
      set -g status "on"
      set -g status-bg "${thm_bg}"
      set -g status-justify "left"
      set -g status-left-length "100"
      set -g status-right-length "100"

      # Messages
      set -g message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
      set -g message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

      # Panes
      set -g pane-border-style "fg=${thm_gray}"
      set -g pane-active-border-style "fg=${thm_blue}"

      # Windows
      set -g window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
      set -g window-status-separator ""
      set -g window-status-style "fg=${thm_fg},bg=${thm_bg},none"

      # Statusline - current window
      set -g window-status-current-format "#[fg=${thm_blue},bg=${thm_bg}] #I: #[fg=${thm_magenta},bg=${thm_bg}](✓) #[fg=${thm_cyan},bg=${thm_bg}]#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=${thm_magenta},bg=${thm_bg}]"

      # Statusline - other windows
      set -g window-status-format "#[fg=${thm_blue},bg=${thm_bg}] #I: #[fg=${thm_fg},bg=${thm_bg}]#W"

      # Statusline - right side
      set -g status-right "#[fg=${thm_blue},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_bg},bg=${thm_blue},nobold,nounderscore,noitalics] #[fg=${thm_fg},bg=${thm_gray}] #W #{?client_prefix,#[fg=${thm_magenta}],#[fg=${thm_cyan}]}#[bg=${thm_gray}]#{?client_prefix,#[bg=${thm_magenta}],#[bg=${thm_cyan}]}#[fg=${thm_bg}] #[fg=${thm_fg},bg=${thm_gray}] #S "

      # Statusline - left side (empty)
      set -g status-left ""

      # Modes
      set -g clock-mode-colour "${thm_blue}"
      set -g mode-style "fg=${thm_blue} bg=${thm_black4} bold"
    '';
  };
}
