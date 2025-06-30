{
  lib,
  config,
  user,
  ...
}: {
  options.terminals.ghostty.enable = lib.mkEnableOption "Enable the `ghostty` terminal emulator.";

  config = lib.mkIf config.terminals.ghostty.enable {
    home-manager.users.${user} = {
      programs.ghostty.enable = true;
    };
  };
}
