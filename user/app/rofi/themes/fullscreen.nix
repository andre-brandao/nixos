{ pkgs, config, ... }:
with config.lib.stylix.colors;
''
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
    	text-color:       #${base06};
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
    	background-color: #${base00};
    	border-color: #${base0B};
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
    	placeholder-color: #${base06};
    }
    message {
   	    background-color: #${base02};
    	border-color: #${base0D};
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

    	background-color: #${base00};
    	border-color: #${base0C};
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
    	background-color: #${base02};
    	border-color: #${base0B};
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
''
