{ config, ... }:
{
  style = with config.lib.stylix.colors.withHashtag; ''
    * {
        all: unset;
        font-family: "JetBrains Mono";
        font-size: 12pt;
        font-weight: 400;
        transition: all 200ms ease-in-out;
    }

    @define-color base00 ${base00}; @define-color base01 ${base01};
    @define-color base02 ${base02}; @define-color base03 ${base03};
    @define-color base04 ${base04}; @define-color base05 ${base05};
    @define-color base06 ${base06}; @define-color base07 ${base07};

    @define-color base08 ${base08}; @define-color base09 ${base09};
    @define-color base0A ${base0A}; @define-color base0B ${base0B};
    @define-color base0C ${base0C}; @define-color base0D ${base0D};
    @define-color base0E ${base0E}; @define-color base0F ${base0F};

    trough highlight {
      background: @base05;
    }

    scale {
      margin: 0 7px;
    }

    scale trough {
      margin: 0rem 1rem;
      min-height: 8px;
      min-width: 70px;
      border-radius: 12.6px;
    }

    trough slider {
      margin: -10px;
      border-radius: 12.6px;
      box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
      transition: all 0.2s ease;
      background-color: @base0D;
    }

    trough slider:hover {
      box-shadow:
        0 0 2px rgba(0, 0, 0, 0.8),
        0 0 8px @base0D;
    }

    trough {
      background-color: @base01;
    }

    /* notifications */

    .notification-background {
      box-shadow:
        0 0 8px 0 rgba(0, 0, 0, 0.8),
        inset 0 0 0 1px @base02;
      border-radius: 12.6px;
      margin: 18px;
      background: @base00;
      color: @base05;
      padding: 0;
    }

    .notification-background .notification {
      padding: 7px;
      border-radius: 12.6px;
    }

    .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 @base08;
    }

    .notification .notification-content {
      margin: 7px;
    }

    .notification .notification-content overlay {
      /* icons */
      margin: 4px;
    }

    .notification-content .summary {
      color: @base05;
    }

    .notification-content .time {
      color: @base04;
    }

    .notification-content .body {
      color: @base04;
    }

    .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6.3px;
      color: @base00;
      background-color: @base08;
    }

    .notification-background .close-button:hover {
      background-color: @base08;
    }

    .notification-background .close-button:active {
      background-color: @base0E;
    }

    .notification .notification-action {
      border-radius: 7px;
      color: @base05;
      box-shadow: inset 0 0 0 1px @base02;
      margin: 4px;
      padding: 8px;
      font-size: 0.2rem; /* controls the button size not text size*/
    }

    .notification .notification-action {
      background-color: @base01;
    }

    .notification .notification-action:hover {
      background-color: @base02;
    }

    .notification .notification-action:active {
      background-color: @base03;
    }

    .notification.critical progress {
      background-color: @base08;
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: @base0D;
    }

    .notification progress,
    .notification trough,
    .notification progressbar {
      border-radius: 12.6px;
      padding: 3px 0;
    }
    /* control center */

    .control-center {
      box-shadow:
        0 0 8px 0 rgba(0, 0, 0, 0.8),
        inset 0 0 0 1px @base01;
      border-radius: 12.6px;
      background-color: @base00;
      color: @base05;
      padding: 14px;
    }

    .control-center .notification-background {
      border-radius: 7px;
      box-shadow: inset 0 0 0 1px @base02;
      margin: 4px 10px;
    }

    .control-center .notification-background .notification {
      border-radius: 7px;
    }

    .control-center .notification-background .notification.low {
      opacity: 0.8;
    }

    .control-center .widget-title > label {
      color: @base05;
      font-size: 1.3em;
    }

    .control-center .widget-title button {
      border-radius: 7px;
      color: @base05;
      background-color: @base01;
      box-shadow: inset 0 0 0 1px @base02;
      padding: 8px;
    }

    .control-center .widget-title button:hover {
      background-color: @base02;
    }

    .control-center .widget-title button:active {
      background-color: @base03;
    }

    .control-center .notification-group {
      margin-top: 10px;
    }

    .control-center .notification-group:focus .notification-background {
      background-color: @base01;
    }

    scrollbar slider {
      margin: -3px;
      opacity: 0.8;
    }

    scrollbar trough {
      margin: 2px 0;
    }

    /* dnd */

    .widget-dnd {
      margin-top: 5px;
      border-radius: 8px;
      font-size: 1.1rem;
    }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: 8px;
      background: @base01;
      box-shadow: none;
    }

    .widget-dnd > switch:checked {
      background: @base0D;
    }

    .widget-dnd > switch slider {
      background: @base02;
      border-radius: 8px;
    }

    /* mpris */

    .widget-mpris-player {
      background: @base01;
      border-radius: 12.6px;
      color: @base05;
    }

    .mpris-overlay {
      background-color: @base01;
      # opacity: 0.9;
      padding: 15px 10px;
    }

    .widget-mpris-album-art {
      -gtk-icon-size: 100px;
      border-radius: 12.6px;
      margin: 0 10px;
    }

    .widget-mpris-title {
      font-size: 1.2rem;
      color: @base05;
    }

    .widget-mpris-subtitle {
      font-size: 1rem;
      color: @base04;
    }

    .widget-mpris button {
      border-radius: 12.6px;
      color: @base05;
      margin: 0 5px;
      padding: 2px;
    }

    .widget-mpris button image {
      -gtk-icon-size: 1.8rem;
    }

    .widget-mpris button:hover {
      background-color: @base01;
    }

    .widget-mpris button:active {
      background-color: @base02;
    }

    .widget-mpris button:disabled {
      opacity: 0.5;
    }

    .widget-menubar > box > .menu-button-bar > button > label {
      font-size: 3rem;
      padding: 0.5rem 2rem;
    }

    .widget-menubar > box > .menu-button-bar > :last-child {
      color: @base08;
    }

    .power-buttons button:hover,
    .powermode-buttons button:hover,
    .screenshot-buttons button:hover {
      background: @base01;
    }

    .control-center .widget-label > label {
      color: @base05;
      font-size: 2rem;
    }

    .widget-buttons-grid {
      padding-top: 1rem;
    }

    .widget-buttons-grid > flowbox > flowboxchild > button label {
      font-size: 2.5rem;
    }

    .widget-volume {
      padding: 1rem 0;
    }

    .widget-volume label {
      color: @base0C;
      padding: 0 1rem;
    }

    .widget-volume trough highlight {
      background: @base0C;
    }

    .widget-backlight trough highlight {
      background: @base0A;
    }

    .widget-backlight label {
      font-size: 1.5rem;
      color: @base0A;
    }

    .widget-backlight .KB {
      padding-bottom: 1rem;
    }

    .image {
      padding-right: 0.5rem;
    }
  '';
}
