{config, lib, pkgs, ... }: 
{
    # programs.ssh = {
    #     startAgent = true;
    # };

    services.gnome.gcr-ssh-agent.enable = true;
}