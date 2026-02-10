{ pkgs, ... }: {
  # Canal stable pour garantir que les paquets existent
  channel = "stable-23.11";

  # On installe le strict minimum via Nix pour laisser Pip gérer le reste (plus stable)
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.postgresql
    pkgs.redis
    pkgs.git
  ];

  env = {
    PYTHON_VERSION = "3.11";
    DJANGO_SETTINGS_MODULE = "config.settings";
  };

  idx = {
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
    ];

    workspace = {
      # Installation automatique au premier démarrage
      onCreate = {
        setup = ''
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
          python manage.py migrate
        '';
      };
    };

    previews = {
      enable = true;
      previews = {
        web = {
          # On change de répertoire vers backend puis on utilise le python du venv local
          command = ["sh" "-c" "cd backend && ./venv/bin/python manage.py runserver 0.0.0.0:$PORT"];
          manager = "web";
          env = {
            PORT = "8000";
          };
        };
      };
    };
  };
}
