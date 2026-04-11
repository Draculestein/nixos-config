{ den, ... }: {
  den.aspects.hyprland.provides.appearance = {
    homeManager = { ... }: {
      wayland.windowManager.hyprland.settings = {
        general = {
          border_size = 4;
          gaps_in = 5;
          gaps_out = 10;
          layout = "scrolling";
          resize_on_border = true;
          locale = "en_US";
        };

        decoration = {
          rounding = 20;
          rounding_power = 2;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            vibrancy = 0.1696;
          };
        };

        cursor = {
          no_hardware_cursors = 0;
        };
      };
    };
  };
}
