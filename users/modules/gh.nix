{config, lib, pkgs, ...}:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;

    settings = {
      git_protocol = "ssh";
    
      prompt = "enabled";
    
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
    
  };
}