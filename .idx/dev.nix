{ pkgs, ... }: {
  # Packages à installer
  packages = [
    pkgs.python312
    pkgs.python312Packages.pip
    pkgs.python312Packages.virtualenv
    pkgs.postgresql
    pkgs.redis
    pkgs.git
  ];

  # Configuration de l'environnement
  env = {
    PYTHON_VERSION = "3.12";
    DJANGO_SETTINGS_MODULE = "config.settings";
  };

  # Commandes de démarrage
  idx = {
    # Extensions recommandées
    extensions = [
      "ms-python.python"
      "ms-python.vscode-pylance"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    # Workspace configuration
    workspace = {
      # Lors de la création du workspace
      onCreate = {
        # Backend Django
        backend-setup = ''
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install -r requirements.txt
          python manage.py migrate
        '';
        
        # Mobile Flutter
        mobile-setup = ''
          cd mobile
          flutter pub get
        '';
      };

      # Lors de l'ouverture du workspace
      onStart = {
        # Démarrer le serveur Django
        django-server = ''
          cd backend
          source venv/bin/activate
          python manage.py runserver 0.0.0.0:8000
        '';
      };
    };

    # Prévisualisation
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["cd" "backend" "&&" "source" "venv/bin/activate" "&&" "python" "manage.py" "runserver" "0.0.0.0:$PORT"];
          manager = "web";
          env = {
            PORT = "8000";
          };
        };
      };
    };
  };
}
