{ pkgs, ... }: {
  # Canal de paquets
  channel = "stable-24.05";

  # Paquets minimaux et stables
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.virtualenv
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
      # S'exécute UNE SEULE FOIS à la création
      onCreate = {
        setup = ''
          # Backend Setup
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
          python manage.py migrate
          
          # Mobile Setup (Si Flutter est présent)
          if [ -d "../mobile" ]; then
            cd ../mobile
            # flutter pub get # Sera géré par l'extension Flutter
          fi
        '';
      };

      # S'exécute à CHAQUE démarrage
      onStart = {
        django-server = ''
          cd backend
          source venv/bin/activate
          python manage.py runserver 0.0.0.0:8000
        '';
      };
    };

    # Prévisualisation Web
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
