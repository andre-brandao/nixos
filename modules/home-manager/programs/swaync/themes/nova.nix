{ config, ... }:
{
  style = with config.lib.stylix.colors.withHashtag; /* css */ ''
    @define-color base00 ${base00}; @define-color base01 ${base01};
    @define-color base02 ${base02}; @define-color base03 ${base03};
    @define-color base04 ${base04}; @define-color base05 ${base05};
    @define-color base06 ${base06}; @define-color base07 ${base07};

    @define-color base08 ${base08}; @define-color base09 ${base09};
    @define-color base0A ${base0A}; @define-color base0B ${base0B};
    @define-color base0C ${base0C}; @define-color base0D ${base0D};
    @define-color base0E ${base0E}; @define-color base0F ${base0F};
    @define-color text            @base05;
    @define-color background      alpha(@base00, .8);
    @define-color background-sec  alpha(@base01, .6);
    @define-color background-alt  alpha(@base01, .4);
    @define-color selected        @base0D;
    @define-color hover           alpha(@selected, .4);
    @define-color urgent          @base08;

    * {
      color:            @text;

      all: unset;
      font-size: 14px;
      font-family: "JetBrains Mono Nerd Font 10";
      transition: 200ms;

    }

    /* Avoid 'annoying' backgroud */
    .blank-window {
      background: transparent;
    }

    /* CONTROL CENTER ------------------------------------------------------------------------ */

    .control-center {
      background: alpha(@background, .69);
      border-radius: 24px;
      border: 1px solid @selected;
      box-shadow: 0 0 10px 0 rgba(0,0,0,.6);
      margin: 18px;
      padding: 12px;
    }

    /* Notifications  */
    .control-center .notification-row .notification-background,
    .control-center .notification-row .notification-background .notification.critical {
      background-color: @background-alt;
      border-radius: 16px;
      margin: 4px 0px;
      padding: 4px;
    }

    .control-center .notification-row .notification-background .notification.critical {
      color: @urgent;
    }

    .control-center .notification-row .notification-background .notification .notification-content {
      margin: 6px;
      padding: 8px 6px 2px 2px;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
      background: alpha(@selected, .6);
      color: @text;
      border-radius: 12px;
      margin: 6px;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      background: @selected;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      background-color: @selected;
    }

    /* Buttons */

    .control-center .notification-row .notification-background .close-button {
      background: transparent;
      border-radius: 6px;
      color: @text;
      margin: 0px;
      padding: 4px;
    }

    .control-center .notification-row .notification-background .close-button:hover {
      background-color: @urgent;
    }

    .control-center .notification-row .notification-background .close-button:active {
      background-color: @urgent;
    }

    progressbar,
    progress,
    trough {
      border-radius: 12px;
    }

    progressbar {
      background-color: rgba(255,255,255,.1);
    }

    /* Sliders */
    scale trough {
      min-height: 8px;
      min-width: 70px;
      border-radius: 12px;
      background-color: @background-alt;
    }

    trough slider {
      min-height: 20px;
      min-width: 20px;
      margin: -6px;
      border-radius: 12px;
      background-color: @selected;
      box-shadow: 0 0 4px rgba(0, 0, 0, 0.6);
    }

    trough slider:hover {
      background-color: @selected;
      box-shadow: 0 0 8px @selected;
    }

    /* Notifications expanded-group */

    .notification-group {
      margin: 2px 8px 2px 8px;

    }
    .notification-group-headers {
      font-weight: bold;
      font-size: 1.25rem;
      color: @text;
      letter-spacing: 2px;
    }

    .notification-group-icon {
      color: @text;
    }

    .notification-group-collapse-button,
    .notification-group-close-all-button {
      background: transparent;
      color: @text;
      margin: 4px;
      border-radius: 6px;
      padding: 4px;
    }

    .notification-group-collapse-button:hover,
    .notification-group-close-all-button:hover {
      background: @hover;
    }

    /* WIDGETS --------------------------------------------------------------------------- */

      /* Notification clear button */
    .widget-title {
      font-size: 1.2em;
      margin: 6px;
    }

    .widget-title button {
      background: @background-alt;
      border-radius: 6px;
      padding: 4px 16px;
    }

    .widget-title button:hover {
      background-color: @hover;
    }

    .widget-title button:active {
      background-color: @selected;
    }

      /* Do not disturb */
    .widget-dnd {
      margin: 6px;
      font-size: 1.2rem;
    }

    .widget-dnd > switch {
      background: @background-alt;
      font-size: initial;
      border-radius: 8px;
      box-shadow: none;
      padding: 2px;
    }

    .widget-dnd > switch:hover {
      background: @hover;
    }

    .widget-dnd > switch:checked {
      background: @selected;
    }

    .widget-dnd > switch:checked:hover {
      background: @hover;
    }

    .widget-dnd > switch slider {
      background: @text;
      border-radius: 6px;
    }

      /* Buttons menu */
    .widget-buttons-grid {
      font-size: x-large;
      padding: 6px 2px;
      margin: 6px;
      border-radius: 12px;
      background: @background-alt;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button {
      margin: 4px 10px;
      padding: 6px 12px;
      background: transparent;
      border-radius: 8px;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button:hover {
      background: @hover;
    }


      /* Music player */
    .widget-mpris {
        background: @background-alt;
        border-radius: 16px;
        color: @text;
        margin:  20px 6px;
    }

    .widget-mpris-player {
        background: @background-sec;
        border-radius: 22px;
        padding: 6px 14px;
        margin: 6px;
    }

    .mpris-overlay {
        background-color: @background-sec;
        padding: 6px 14px;
    }

    .widget-mpris > box > button {
      color: @text;
      border-radius: 20px;
    }

    .widget-mpris button {
      color: alpha(@text, .6);
    }

    .widget-mpris button:hover {
      color: @text;
    }

    .widget-mpris-album-art {
      border-radius: 16px;
    }

    .widget-mpris-title {
        font-weight: 700;
        font-size: 1rem;
    }

    .widget-mpris-subtitle {
        font-weight: 500;
        font-size: 0.8rem;
    }

    /* Volume */
    .widget-volume {
      padding: 4px;
      margin: 6px;
    }

    .widget-volume label {
      color: @text;
      padding: 0 1rem;
      font-size: 1rem;
    }

    .widget-volume trough highlight {
      background: @selected;
    }

    /* Brightness */
    .widget-backlight {
      padding: 4px;
      margin: 6px;
    }

    .widget-backlight label {
      color: @text;
      padding: 0 1rem;
      font-size: 1rem;
    }

    .widget-backlight trough highlight {
      background: @base0A;
    }


    * {

      /*background-alt:        @color1;      Buttons background */
      /*selected:              @color2;      Button selected */
      /*hover:                 @color5;      Hover button */
      /*urgent:                @color6;      Urgency critical */
      /*text-selected:         @background; */

      color: @text;

      all: unset;
      font-size: 14px;
      font-family: "JetBrains Mono Nerd Font 10";
      transition: 200ms;

    }

    .notification-row {
      outline: none;
      margin: 0;
      padding: 0px;
    }

    .floating-notifications.background .notification-row .notification-background {
      /*background: alpha(@background, .69);*/
      background: @background;
      box-shadow: 0 0 8px 0 rgba(0,0,0,.6);
      border-radius: 24px;
      margin: 8px;
      padding: 0;
    }

    .floating-notifications.background .notification-row .notification-background .notification {
      padding: 6px;
      border-radius: 12px;
    }

    .floating-notifications.background .notification-row .notification-background .notification.critical {
      border: 2px solid @urgent;
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content {
      margin: 14px;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 8px;
      background-color: @background-alt ;
      margin: 6px;
      border: 1px solid transparent;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      background-color: @hover;
      border: 1px solid @selected;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      background-color: @selected;
      color: @background;
    }

    .image {
      margin: 10px 20px 10px 0px;
    }

    .summary {
      font-weight: 800;
      font-size: 1rem;
    }

    .body {
      font-size: 0.8rem;
    }

    .floating-notifications.background .notification-row .notification-background .close-button {
      margin: 6px;
      padding: 2px;
      border-radius: 6px;
      background-color: transparent;
      border: 1px solid transparent;
    }

    .floating-notifications.background .notification-row .notification-background .close-button:hover {
      background-color: @urgent;
    }

    .floating-notifications.background .notification-row .notification-background .close-button:active {
      background-color: @urgent;
      color: @background;
    }

    .notification.critical progress {
      background-color: @selected;
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: @selected;
    }

    /* NOTIFICATION */
    * {

      /*background-alt:        @color1;      Buttons background */
      /*selected:              @color2;      Button selected */
      /*hover:                 @color5;      Hover button */
      /*urgent:                @color6;      Urgency critical */
      /*text-selected:         @background; */

      color: @text;

      all: unset;
      font-size: 14px;
      font-family: "JetBrains Mono Nerd Font 10";
      transition: 200ms;

    }

    .notification-row {
      outline: none;
      margin: 0;
      padding: 0px;
    }

    .floating-notifications.background .notification-row .notification-background {
      background: alpha(@background, .55);
      box-shadow: 0 0 8px 0 rgba(0,0,0,.6);
      border-radius: 24px;
      margin: 16px;
      padding: 0;
    }

    .floating-notifications.background .notification-row .notification-background .notification {
      padding: 6px;
      border-radius: 12px;
    }

    .floating-notifications.background .notification-row .notification-background .notification.critical {
      border: 2px solid @urgent;
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content {
      margin: 14px;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 8px;
      background-color: @background-alt ;
      margin: 6px;
      border: 1px solid transparent;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      background-color: @hover;
      border: 1px solid @selected;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      background-color: @selected;
      color: @background;
    }

    .image {
      margin: 10px 20px 10px 0px;
    }

    .summary {
      font-weight: 800;
      font-size: 1rem;
    }

    .body {
      font-size: 0.8rem;
    }

    .floating-notifications.background .notification-row .notification-background .close-button {
      margin: 6px;
      padding: 2px;
      border-radius: 6px;
      background-color: transparent;
      border: 1px solid transparent;
    }

    .floating-notifications.background .notification-row .notification-background .close-button:hover {
      background-color: @urgent;
    }

    .floating-notifications.background .notification-row .notification-background .close-button:active {
      background-color: @urgent;
      color: @background;
    }

    .notification.critical progress {
      background-color: @selected;
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: @selected;
    }
  '';
}
