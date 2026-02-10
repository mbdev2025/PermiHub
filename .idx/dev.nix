{ pkgs, ... }: {
  channel = "stable-23.11";

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

  services = {
    redis.enable = true;
    postgres = {
      enable = true;
      package = pkgs.postgresql;
    };
  };

  idx = {
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
      "ms-azuretools.vscode-docker"
      "redhat.vscode-yaml"
    ];

    workspace = {
      onCreate = {
        setup = ''
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements-idx.txt
          if [ ! -f .env ]; then
            cp .env.example .env
          fi
          python manage.py migrate
          
          cd ../mobile
          if command -v flutter > /dev/null; then
            flutter pub get
          fi
          
          cd ..
          echo "✅ PermiHub est maintenant prêt et optimisé pour IDX !"
        '';
      };
    };

    previews = {
      enable = true;
      previews = {
        web = {
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
