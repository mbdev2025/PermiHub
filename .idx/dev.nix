{ pkgs, ... }: {
  # Canal stable-23.11 pour une compatibilité maximale
  channel = "stable-23.11";

  packages = [
    pkgs.python311
    pkgs.postgresql
    pkgs.redis
    pkgs.git
  ];

  # Configuration de l'environnement
  env = {
    PYTHON_VERSION = "3.11";
    DJANGO_SETTINGS_MODULE = "config.settings";
  };

  idx = {
    # Extensions VS Code
    extensions = [
      "ms-python.python"
      "ms-python.vscode-pylance"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    # Workspace configuration
    workspace = {
      # S'exécute à la création du workspace
      onCreate = {
        setup = ''
          # On s'assure d'être à la racine du projet
          cd /home/user/workspace || cd /workspace

          # Backend Setup
          if [ -d "backend" ]; then
            cd backend
            # Nettoyage si venv corrompu
            rm -rf venv
            python3 -m venv venv
            source venv/bin/activate
            python3 -m pip install --upgrade pip
            python3 -m pip install -r requirements.txt
            python3 manage.py migrate
            cd ..
          fi
        '';
      };

      # S'exécute à chaque démarrage
      onStart = {
        django-server = ''
          if [ -d "backend" ]; then
            cd backend
            # On vérifie si le venv existe
            if [ -d "venv" ]; then
              source venv/bin/activate
              python3 manage.py runserver 0.0.0.0:8000
            fi
          fi
        '';
      };
    };

    # Prévisualisation Web
    previews = {
      enable = true;
      previews = {
        web = {
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
