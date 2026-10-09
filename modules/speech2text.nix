{
  flake.nixosModules.speech2text =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: _prev: {
          speech2text-extension-service = final.python3Packages.buildPythonApplication rec {
            pname = "speech2text-extension-service";
            version = "1.2.0-unstable-2026-10-06";
            pyproject = true;

            src = final.fetchFromGitHub {
              owner = "kavehtehrani";
              repo = "speech2text-extension";
              rev = "e2a27603f899d3affb95efa99a8e8a982f3e4b83";
              hash = "sha256-Z2KlzfspYmyV5YD5OF3PO0RfyZkY6g2zk1xIfgytLBo=";
            };

            sourceRoot = "${src.name}/service";

            build-system = [ final.python3Packages.setuptools ];

            dependencies = with final.python3Packages; [
              dbus-next
              openai-whisper
              torch
              torchaudio
            ];

            # The service shells out to these by name and reports them as missing
            # dependencies to the extension rather than linking against anything.
            makeWrapperArgs = [
              "--prefix PATH : ${
                final.lib.makeBinPath [
                  final.ffmpeg
                  final.util-linux
                  final.which
                  final.wl-clipboard
                  final.xclip
                  final.xdotool
                ]
              }"
            ];

            # Upstream leaves the activation path for its install script to rewrite.
            postInstall = ''
              install -Dm644 data/org.gnome.Shell.Extensions.Speech2Text.service \
                $out/share/dbus-1/services/org.gnome.Shell.Extensions.Speech2Text.service
              substituteInPlace $out/share/dbus-1/services/org.gnome.Shell.Extensions.Speech2Text.service \
                --replace-fail /usr/bin/speech2text-service $out/bin/speech2text-extension-service
            '';

            doCheck = false;

            meta = {
              description = "D-Bus service backing the GNOME Speech2Text extension";
              homepage = "https://github.com/kavehtehrani/speech2text-extension";
              license = final.lib.licenses.gpl3Plus;
              mainProgram = "speech2text-extension-service";
              platforms = final.lib.platforms.linux;
            };
          };
        })
      ];

      environment.systemPackages = [
        pkgs.gnomeExtensions.gnome-speech2text
        pkgs.speech2text-extension-service
      ];

      programs.dconf.profiles.user.databases = [
        {
          settings."org/gnome/shell".enabled-extensions = [ "gnome-speech2text@kaveh.page" ];
        }
      ];

      # The extension only talks to a service its own installer placed, which it
      # recognises by this marker; the values just populate its settings dialog.
      hjem.users.sshine.files.".local/share/speech2text-extension-service/install-state.conf".text = ''
        device=cpu
        model=base
        installer_mode=nix
      '';
    };
}
