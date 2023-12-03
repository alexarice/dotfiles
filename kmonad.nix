{ inputs, ... }:

{
  imports = [
    inputs.kmonad.nixosModules.default
  ];

  services.kmonad = {
    enable = true;

    keyboards.internal = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";

      defcfg = {
        enable = true;
        fallthrough = true;
      };

      config = ''
        (defsrc
          a s d f     j k l ;
        )
        (deflayer U_BASE
          (tap-hold-next-release 200 a met)
          (tap-hold-next-release 200 s alt)
          (tap-hold-next-release 200 d ctl)
          (tap-hold-next-release 200 f sft)
          (tap-hold-next-release 200 j sft)
          (tap-hold-next-release 200 k ctl)
          (tap-hold-next-release 200 l alt)
          (tap-hold-next-release 200 ; met)
        )
      '';
    };
  };

}
