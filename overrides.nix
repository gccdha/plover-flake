{
  lib,
  ruamel-yaml,
  prompt-toolkit,
  pysdl2,
  setuptools-scm,
  utils,
  evdev,
  xkbcommon,
  buildPythonPackage,
  fetchPypi
}: self: super:
let
  simplefuzzyset = buildPythonPackage rec {
    pname = "simplefuzzyset";
    version = "0.0.12";

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-mhsww4tq+3bGYAvdZsHB3D2FBbCC6ePUZvYPQOi34fI=";
    };
  };
in
{
  plover-yaml-dictionary = super.plover-yaml-dictionary.overrideAttrs (old: {
    propagatedBuildInputs = [ruamel-yaml];
  });
  plover-console-ui = super.plover-console-ui.overrideAttrs (old: {
    propagatedBuildInputs = [prompt-toolkit];
    doCheck = false;
    doInstallCheck = false;
  });
  plover-controller = super.plover-controller.overrideAttrs (old: {
    propagatedBuildInputs = [pysdl2];
    doCheck = false;
    doInstallCheck = false;
  });
  plover-dict-commands = super.plover-dict-commands.overrideAttrs (old: {
    propagatedBuildInputs = [setuptools-scm];
  });
  plover-uinput = super.plover-uinput.overrideAttrs (old: {
    propagatedBuildInputs = [evdev xkbcommon];
  });
  plover-lapwing-aio = super.plover-lapwing-aio.overrideAttrs (old: {
    propagatedBuildInputs = [
      self.plover-stitching
      self.plover-python-dictionary
      self.plover-modal-dictionary
      self.plover-last-translation
      self.plover-dict-commands
    ];
  });
  plover-emoji = super.plover-emoji.overrideAttrs (old: {
    propagatedBuildInputs = [
      simplefuzzyset
    ];
  });
}
