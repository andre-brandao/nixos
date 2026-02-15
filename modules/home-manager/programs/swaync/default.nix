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
      control-center-margin-bottom = 10;
      control-center-margin-left = 10;
      control-center-margin-right = 10;
      control-center-margin-top = 10;
      control-center-width = 420;
      control-center-height = 1025;
      notification-2fa-action = true;
      # notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      # Suggested additions for better UX:
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = true;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      notification-window-width = 420;
      widget-config = {
        backlight = {
          label = "󰃟";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-radius = 7;
          image-size = 96;
        };
        title = {
          button-text = "Clear";
          clear-all-button = true;
          text = "Notifications";
        };
        volume = {
          label = "󰕾";
        };
      };
      widgets = [
        "inhibitors"
        "dnd"
        "buttons-grid"
        "mpris"
        "volume"
        "backlight"
        "title"
        "notifications"
      ];
    };

    style = (import ./themes/nova.nix { inherit pkgs config; }).style;
  };
}
