{ config, lib, pkgs, ... }:

{
  options = {
    environment.fhsPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = lib.mdDoc ''
        Put these packages in /lib directory
      '';
    };
    environment.fhsLib = lib.mkOption {
      default = "${pkgs.coreutils}/bin/env";
      type = lib.types.nullOr lib.types.path;
      visible = false;
      description = lib.mdDoc ''
        The generated /lib directory
      '';
    };
  };

  config = {
    environment.systemPackages = config.environment.fhsPackages;

    environment.fhsLib = if builtins.length config.environment.fhsPackages == 0 then null else pkgs.buildEnv {
      name = "fhs-lib-path";
      paths = map lib.getLib config.environment.fhsPackages;
      pathsToLink = [ "/lib" ];
    };

    systemd.tmpfiles.rules = lib.mkIf (config.environment.fhsLib != null) [
      "L+ /lib64 - - - - ${config.environment.fhsLib}/lib"
    ];
  };
}
