{ pkgs, config, ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      # notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
    };

    style = with config.lib.stylix.colors.withHashtag; ''
      * {
          font-family: "${config.lib.stylix.fonts.sansSerif.name}";
          font-size: 12pt;
      }
      @define-color base00 ${base00}; @define-color base01 ${base01};
      @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05};
      @define-color base06 ${base06}; @define-color base07 ${base07};

      @define-color base08 ${base08}; @define-color base09 ${base09};
      @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D};
      @define-color base0E ${base0E}; @define-color base0F ${base0F};


      progress,
      progressbar,
      trough {
        border: 1px solid @base0D;
      }

      trough {
        background: @base01;
      }

      .notification.low {
        border: 1px solid @base03;
      }

      .notification.low progress {
        background: @base03;
      }

      .notification.normal {
        border: 1px solid @base0D;
      }

      .notification.normal progress {
        background: @base0F;
      }

      .notification.critical {
        border: 1px solid @base08;
      }

      .notification.critical progress {
        background: @base08;
      }

      .summary {
        color: @base05;
      }

      .body {
        color: @base06;
      }

      .time {
        color: @base06;
      }

      .notification-action {
        color: @base05;
        background: @base01;
      }

      .notification-action:hover {
        background: @base01;
        color: @base05;
      }

      .notification-action:active {
        background: @base0F;
        color: @base05;
      }

      .close-button {
        color: @base02;
        background: @base08;
      }

      .close-button:hover {
        background: lighter(@base08);
        color: lighter(@base02);
      }

      .close-button:active {
        background: @base08;
        color: @base00;
      }

      .notification-content {
        background: @base00;
        border: 1px solid @base0D;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: transparent;
        color: @base05;
      }

      .notification-group .notification-group-buttons,
      .notification-group .notification-group-headers {
        color: @base05;
      }

      .notification-group .notification-group-headers .notification-group-icon {
        color: @base05;
      }

      .notification-group .notification-group-headers .notification-group-header {
        color: @base05;
      }

      .notification-group.collapsed .notification-row .notification {
        background: @base01;
      }

      .notification-group.collapsed:hover
        .notification-row:not(:only-child)
        .notification {
        background: @base01;
      }

      .control-center {
        background: @base00;
        border: 1px solid @base0D;
        color: @base05;
      }

      .control-center .notification-row .notification-background {
        background: @base00;
        color: @base05;
      }

      .control-center .notification-row .notification-background:hover {
        background: @base00;
        color: @base05;
      }

      .control-center .notification-row .notification-background:active {
        background: @base0F;
        color: @base05;
      }

      .widget-title {
        color: @base05;
        margin: 0.5rem;
      }

      .widget-title > button {
        background: @base01;
        border: 1px solid @base0D;
        color: @base05;
      }

      .widget-title > button:hover {
        background: @base01;
      }

      .widget-dnd {
        color: @base05;
      }

      .widget-dnd > switch {
        background: @base01;
        border: 1px solid @base0D;
      }

      .widget-dnd > switch:hover {
        background: @base01;
      }

      .widget-dnd > switch:checked {
        background: @base0F;
      }

      .widget-dnd > switch slider {
        background: @base06;
      }

      .widget-mpris {
        color: @base05;
      }

      .widget-mpris .widget-mpris-player {
        background: @base01;
        border: 1px solid @base0D;
      }

      .widget-mpris .widget-mpris-player button:hover {
        background: @base01;
      }

      .widget-mpris .widget-mpris-player > box > button {
        border: 1px solid @base0D;
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        background: @base01;
        border: 1px solid @base0D;
      }
    '';
  };
}
