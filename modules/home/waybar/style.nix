{...}: let
  custom = {
    font = "JetBrainsMono Nerd Font";
    font_size = "22px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    secondary_accent = "#89b4fa";
    tertiary_accent = "#f5f5f5";
    background = "#11111B";
  };
in {
  programs.waybar.style = ''

      * {
          border: none;
          border-radius: 0px;
          padding: 0;
          margin: 0;
          min-height: 0px;
          font-family: ${custom.font};
          font-weight: ${custom.font_weight};
      }

      window#waybar {
    background: ${custom.background};
      }

      #workspaces {
          font-size: ${custom.font_size};

      }
      #workspaces button {
          color: ${custom.text_color};
          padding-left:  6px;
          padding-right: 6px;
      }
      #workspaces button.empty {
          color: #6c7086;
      }
      #workspaces button.active {
          color: #b4befe;
      }

      #tray, #pulseaudio, #network, #cpu, #memory, #disk, #clock, #battery, #custom-notification {
          font-size: ${custom.font_size};
          color: ${custom.text_color};
      }

      #cpu {
          padding-left: 5px;
          padding-right: 9px;
      }
      #memory {
          padding-left: 9px;
          padding-right: 9px;
      }
      #disk {
          padding-left: 9px;
          padding-right: 5px;
      }

      #tray {
          margin-left: 7px;
          padding-right: 5px;
      }

      #pulseaudio {
          padding-left: 5px;
          padding-right: 9px;
      }
      #battery {
          padding-left: 9px;
          padding-right: 9px;
      }
      #network {
          padding-left: 9px;
          padding-right: 5px;
      }

      custom-notification {
          padding-left: 15px;
          padding-right: 20px;
      }

      #clock {
          padding-left: 9px;
          padding-right: 15px;
      }

      #custom-launcher {
          font-size: ${custom.font_size};
          color: #b4befe;
          font-weight: ${custom.font_weight};
          padding-left: 10px;
          padding-right: 15px;
      }
  '';
}
