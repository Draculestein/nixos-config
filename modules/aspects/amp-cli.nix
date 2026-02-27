{ den, ... }: {
  den.aspects.amp-cli = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.amp-cli ];

      home.file.".config/amp/settings.json" = {
        enable = true;
        text = ''
          "amp.defaultVisibility": {
            "github.com/heavyset-tech/heavyset-api": "private",
            "github.com/heavyset-tech/heavyset-admin": "private",
            "github.com/heavyset-tech/heavyset-apt-ui-classic-1": "private",
            "github.com/heavyset-tech/heavyset-scripts": "private",
          },
          "amp.git.commit.ampThread.enabled": false,
          "amp.git.commit.coauthor.enabled": false
        '';
      };
    };
  };
}
