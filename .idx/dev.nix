{ pkgs, ... }: {
  # Canal stable pour garantir que les paquets existent
  channel = "stable-23.11";

  # Paquets système essentiels
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.virtualenv
    pkgs.postgresql
    pkgs.redis
    pkgs.git
  ];

  env = {
    PYTHON_VERSION = "3.11";
    DJANGO_SETTINGS_MODULE = "config.settings";
  };

  idx = {
    # Extensions VS Code pré-installées
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
      "ms-azuretools.vscode-docker"
      "redhat.vscode-yaml"
    ];

    workspace = {
      # S'exécute AUTOMATIQUEMENT à la création (UNE SEULE FOIS)
      onCreate = {
        setup = ''
          # On s'assure d'être dans le dossier backend
          cd backend
          
          # Création et activation de l'environnement virtuel
          python3 -m venv venv
          source venv/bin/activate
          
          # Installation des dépendances
          pip install --upgrade pip
          pip install -r requirements-idx.txt
          
          # Préparation de la base de données
          python manage.py migrate
          
          cd ..
          echo "Initialisation terminée avec succès !"
        '';
      };
    };

    # Prévisualisation Web (Port 8000)
    previews = {
      enable = true;
      previews = {
        web = {
          # Utilisation du chemin direct vers le python du venv pour éviter l'erreur ModuleNotFound
          command = ["backend/venv/bin/python" "backend/manage.py" "runserver" "0.0.0.0:$PORT"];
          manager = "web";
          env = {
            PORT = "8000";
          };
        };
      };
    };
  };
}
