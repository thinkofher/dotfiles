{
    packageOverrides = pkgs: with pkgs; {
        devEnv = pkgs.buildEnv {
            name = "development-environment";
            paths = [
                neovim
                fd
                ripgrep
                fzf
                zsh
                fossil
                git
            ];
        };
    };
}
