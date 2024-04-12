{ pkgs, config, ... }:
let

  temas = {
    vimjoyer = with config.lib.stylix.colors; ''
        /*****----- Configuration -----*****/
      configuration {
          show-icons:                 true;
          display-drun:               " ";
          display-run:                 " ";
          display-filebrowser:         " ";
          display-window:              " ";
          drun-display-format:        "{name}";
          window-format:              "{w}{c}";
          display-emoji: "🔎 ";
      }

        /*****----- Global Properties -----*****/
        * {
            active-background: #${base0B};
            active-foreground: @foreground;
            normal-background: @background;
            normal-foreground: @foreground;
            urgent-background: #${base08};
            urgent-foreground: @foreground;

            alternate-active-background: @background;
            alternate-active-foreground: @foreground;
            alternate-normal-background: @background;
            alternate-normal-foreground: @foreground;
            alternate-urgent-background: @background;
            alternate-urgent-foreground: @foreground;

            selected-active-background: #${base08};
            selected-active-foreground: @foreground;
            selected-normal-background: #${base0B};
            selected-normal-foreground: @foreground;
            selected-urgent-background: #${base0A};
            selected-urgent-foreground: @foreground;

            background-color: @background;
            background: #${base00};
            foreground: #${base06};
            border-color: @background;
            spacing: 2;
        }

        #window {
            background-color: @background;
            border: 0;
            padding: 2.5ch;
        }

        #mainbox {
            border: 0;
            padding: 0;
        }

        #message {
            border: 2px 0px 0px;
            border-color: @border-color;
            padding: 1px;
        }

        #textbox {
            text-color: @foreground;
        }

        #inputbar {
            children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
        }

        #textbox-prompt-colon {
            expand: false;
            str: ":";
            margin: 0px 0.3em 0em 0em;
            text-color: @normal-foreground;
        }

        #listview {
            fixed-height: 0;
            border: 2px 0px 0px;
            border-color: @border-color;
            spacing: 2px;
            scrollbar: true;
            padding: 2px 0px 0px;
        }

        #element {
            border: 0;
            padding: 1px;
        }

        #element.normal.normal {
            background-color: @normal-background;
            text-color: @normal-foreground;
        }

        #element.normal.urgent {
            background-color: @urgent-background;
            text-color: @urgent-foreground;
        }

        #element.normal.active {
            background-color: @active-background;
            text-color: @active-foreground;
        }

        #element.selected.normal {
            background-color: @selected-normal-background;
            text-color: @selected-normal-foreground;
        }

        #element.selected.urgent {
            background-color: @selected-urgent-background;
            text-color: @selected-urgent-foreground;
        }

        #element.selected.active {
            background-color: @selected-active-background;
            text-color: @selected-active-foreground;
        }

        #element.alternate.normal {
            background-color: @alternate-normal-background;
            text-color: @alternate-normal-foreground;
        }

        #element.alternate.urgent {
            background-color: @alternate-urgent-background;
            text-color: @alternate-urgent-foreground;
        }

        #element.alternate.active {
            background-color: @alternate-active-background;
            text-color: @alternate-active-foreground;
        }

        #scrollbar {
            width: 4px;
            border: 0;
            handle-width: 8px;
            padding: 0;
        }

        #sidebar {
            border: 2px 0px 0px;
            border-color: @border-color;
        }

        #button {
            text-color: @normal-foreground;
        }

        #button.selected {
            background-color: @selected-normal-background;
            text-color: @selected-normal-foreground;
        }

        #inputbar {
            spacing: 0;
            text-color: @normal-foreground;
            padding: 1px;
        }

        #case-indicator {
            spacing: 0;
            text-color: @normal-foreground;
        }

        #entry {
            spacing: 0;
            text-color: @normal-foreground;
        }

        #prompt {
            spacing: 0;
            text-color: @normal-foreground;
        }
        * {
            font: "JetBrains Mono Nerd Font 16px";
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            x-offset:                    0px;
            y-offset:                    0px;
            width:			             600px;
            height:			             700px;
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      2px solid;
            border-radius:               10px;
            border-color:                @selected-normal-background;
            background-color:            @background;
            cursor:                      "default";
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     20px;
            border:                    	 0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @selected;
            background-color:            transparent;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     15px;
            border:                      0px solid;
            border-radius:               12px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            children:                    [ "prompt", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }
        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "::";
            background-color:            inherit;
            text-color:                  inherit;
        }
        entry {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search...";
            placeholder-color:           inherit;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       9;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               false;

            spacing:                     5px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @selected;
            border-radius:               0px;
            background-color:            @background-alt;
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     5px;
            border:                      0px solid;
            border-radius:               10px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            cursor:                      pointer;
        }
        element normal.normal {
            background-color:            transparent;
            text-color:                  @foreground;
        }

        element selected.normal {
            background-image:            @selected;
            text-color:                  @background;
        }
        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        32px;
            cursor:                      inherit;
        }
        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }

        /*****----- Message -----*****/
        error-message {
            padding:                     15px;
            border:                      0px solid;
            border-radius:               10px;
            border-color:                @selected;
            background-color:            @background;
            text-color:                  @foreground;
        }
        textbox {
            background-color:            @background;
            text-color:                  @foreground;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
        }
    '';

    fullscreen = ''
      /*****----- Configuration -----*****/
        configuration {
            show-icons:                 true;
            display-drun:               " ";
            display-run:                 " ";
            display-filebrowser:         " ";
            display-window:              " ";
            drun-display-format:        "{name}";
            window-format:              "{w}{c}";
            display-emoji: "🔎 ";
        }
            /**
         * ROFI Color Theme
         *
         * Fullscreen theme with switchable PREVIEW option.
         * 
         * User: Dave Davenport
         * Copyright: Dave Davenport
         */

        * {
        	background-color: transparent;
        	text-color:       white;
        }

        window {
        	fullscreen:       true;
        	background-color: black/80%;
        	padding:          4em;
        	children:         [ wrap, listview-split];
        	spacing:          1em;
        }


        /** We add an extra child to this is PREVIEW=true */
        listview-split {
          orientation: horizontal;
          spacing: 0.4em;
          children: [listview];
        }

        wrap {
        	expand: false;
        	orientation: vertical;
        	children: [ inputbar, message ];
        	background-image: linear-gradient(white/70%, white/40%);
        	border-color: lightblue;
        	border: 3px;
        	border-radius: 0.4em;
        }

        icon-ib {
        	expand: false;
        	filename: "system-search";
        	vertical-align: 0.5;
        	horizontal-align: 0.5;
        	size: 1em;
        }
        inputbar {
        	spacing: 0.4em;
        	padding: 0.4em;
        	children: [ icon-ib, entry ];
        }
        entry {
        	placeholder: "Search";
        	placeholder-color: black;
        }
        message {
        	background-color: red/20%;
        	border-color: lightsalmon;
        	border: 3px 0px 0px 0px;
        	padding: 0.4em;
        	spacing: 0.4em;
        }

        listview {
        	flow: horizontal;
        	fixed-columns: true;
        	columns: 7;
        	lines: 5;
        	spacing: 1.0em;
        }

        element {
        	orientation: vertical;
        	padding: 0.1em;

        	background-image: linear-gradient(white/5%, white/20%);
        	border-color: lightblue /15%;
        	border: 3px;
        	border-radius: 0.4em;

          children: [element-icon, element-text ];
        }
        element-icon {
        	size: calc(((100% - 8em) / 7 ));
        	horizontal-align: 0.5;
        	vertical-align: 0.5;
        }
        element-text {
        	horizontal-align: 0.5;
        	vertical-align: 0.5;
          padding: 0.2em;
        }

        element selected {
        	background-image: linear-gradient(white/25%, white/10%);
        	border-color: lightblue;
        	border: 3px;
        	border-radius: 0.4em;
        }

        /**
         * Launching rofi with environment PREVIEW set to true
         * will split the screen and show a preview widget.
         */
        @media ( enabled: env(PREVIEW, false)) {
          /** preview widget */
          icon-current-entry {
            expand:          true;
            size:            80%;
          }
          listview-split {
            children: [listview, icon-current-entry];
          }
          listview {
          columns: 4;
          }

        }

        @media ( enabled: env(NO_IMAGE, false)) {
        	listview {
        		columns: 1;
        		spacing: 0.4em;
        	}
        	element {
        		children: [ element-text ];
        	}
        	element-text {
        		horizontal-align: 0.0;
        	}
        }
    '';
  };
in
{
  # xdg.configFile."rofi/config.rasi".source = ./config.rasi;

  xdg.configFile."rofi/config.rasi".text = temas.vimjoyer;

  home.packages = with pkgs; [ rofi-wayland ];

  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  # };
}
