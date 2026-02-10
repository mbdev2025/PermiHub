{ pkgs, ... }: {
  # Utilisation d'un canal stable
  channel = "stable-23.11";

  # Installation de Django et des paquets de base directement via Nix
  # C'est la méthode la plus fiable pour que IDX "voie" les modules
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.django_5 # Django stable
    pkgs.python311Packages.djangorestframework
    pkgs.python311Packages.psycopg2
    pkgs.postgresql
    pkgs.redis
    pkgs.git
  ];

  env = {
    PYTHON_VERSION = "3.11";
    DJANGO_SETTINGS_MODULE = "config.settings";
    PYTHONPATH = ".:backend"; # Aide Python à trouver les modules
  };

  idx = {
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
    ];

    workspace = {
      # Installation des dépendances supplémentaires au premier démarrage
      onCreate = {
        install-extra-deps = ''
          cd backend
          pip install -r requirements.txt
        '';
      };
    };

    previews = {
      enable = true;
      previews = {
        web = {
          # Commande simplifiée qui utilise le python du système (où Nix a injecté Django)
          command = ["python3" "backend/manage.py" "runserver" "0.0.0.0:$PORT"];
          manager = "web";
          env = {
            PORT = "8000";
          };
        };
      };
    };
  };
}
