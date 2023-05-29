import ./make-test-python.nix ({ pkgs, ... }: {
  name = "fhs-lib";

  nodes.machine = { pkgs, ... }:

    {
      environment.fhsPackages = with pkgs; [
        glibc-old
      ];
    };

  testScript = ''
    start_all()
    machine.succeed("test -e /lib/libc.so")
  '';
})
