# 🚀 Stack Technique de Référence - Project IDX

> **Version validée et fonctionnelle sur Project IDX**  
> Dernière mise à jour : 10 février 2026

---

## 📋 Table des Matières

1. [Environnement de Base](#environnement-de-base)
2. [Backend (Django)](#backend-django)
3. [Frontend Mobile (Flutter)](#frontend-mobile-flutter)
4. [Configuration IDX](#configuration-idx)
5. [Checklist de Démarrage](#checklist-de-démarrage)

---

## 🖥️ Environnement de Base

### Système d'exploitation
- **OS** : NixOS (géré par Project IDX)
- **Canal Nix** : `stable-23.11`

### Langage & Runtime
- **Python** : `3.11` (via `pkgs.python311`)
- **Gestionnaire de paquets** : `pip` + `virtualenv`
- **Dart/Flutter** : SDK compatible `>=3.2.0 <4.0.0`

### Services Infrastructure
- **Base de données** : PostgreSQL (via `pkgs.postgresql`)
- **Cache/Queue** : Redis (via `pkgs.redis`)
- **Contrôle de version** : Git (via `pkgs.git`)

---

## 🐍 Backend (Django)

### Framework Principal
```
Django==5.1.15
```
**⚠️ Important** : Django 6.x nécessite Python 3.12. Rester sur 5.1.x pour Python 3.11.

### API REST
```
djangorestframework==3.16.1
djangorestframework-simplejwt==5.5.1
drf-spectacular==0.29.0
django-cors-headers==4.9.0
django-filter==24.3
```
**⚠️ Important** : `django-filter==25.2` nécessite Django 5.2 (inexistant). Utiliser `24.3`.

### CMS (Headless)
```
wagtail==7.3
django-modelcluster==6.4.1
django-taggit==6.1.0
django-treebeard==4.8.0
```

### Tâches Asynchrones
```
celery==5.6.2
kombu==5.6.2
redis==7.1.0
```

### Base de Données
```
psycopg2-binary==2.9.11
```

### Paiements & Intégrations
```
stripe==14.3.0
```

### Stockage Cloud (AWS S3 / MinIO)
```
django-storages==1.14.6
boto3==1.42.44
botocore==1.42.44
```

### Utilitaires
```
django-environ==0.12.0
whitenoise==6.11.0
beautifulsoup4==4.14.3
pillow==12.1.0
```

### Tests
```
pytest==9.0.2
pytest-django==4.11.1
```

---

## 📱 Frontend Mobile (Flutter)

### Gestion d'État
```yaml
flutter_riverpod: ^2.5.1
```

### Navigation
```yaml
go_router: ^13.2.0
```

### Réseau & API
```yaml
dio: ^5.4.0
http: ^1.2.0
```

### Stockage Local
```yaml
shared_preferences: ^2.2.2
```

### Interface Utilisateur
```yaml
google_fonts: ^6.1.0
flutter_svg: ^2.0.9
```

### Internationalisation
```yaml
intl: ^0.19.0
```

---

## ⚙️ Configuration IDX

### Fichier `.idx/dev.nix` (Template)

```nix
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

  idx = {
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
    ];

    workspace = {
      onCreate = {
        setup = ''
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
          python manage.py migrate
          cd ..
          echo "✅ Environnement initialisé"
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
```

### Fichier `.env` (Template)

```bash
# === CONFIGURATION GENERALE ===
DEBUG=True
SECRET_KEY=django-insecure-CHANGEZ-MOI-EN-PRODUCTION
ALLOWED_HOSTS=localhost,127.0.0.1,*.idx.google.com

# === DATABASE ===
# Pour SQLite (développement)
DATABASE_URL=sqlite:////home/user/VOTRE_PROJET/backend/db.sqlite3

# Pour PostgreSQL (production)
# DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# === REDIS ===
REDIS_URL=redis://localhost:6379/0

# === STRIPE (PAIEMENTS) ===
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# === AWS S3 (STOCKAGE) ===
# AWS_ACCESS_KEY_ID=...
# AWS_SECRET_ACCESS_KEY=...
# AWS_STORAGE_BUCKET_NAME=...
# AWS_S3_REGION_NAME=eu-west-3
```

---

## ✅ Checklist de Démarrage (Nouveau Projet)

### 1. Création du Workspace IDX
- [ ] Importer le dépôt GitHub
- [ ] Attendre la fin du build initial (barre orange)

### 2. Configuration Backend
- [ ] Vérifier que `backend/venv` existe
- [ ] Copier `.env.example` vers `.env`
- [ ] Modifier `SECRET_KEY` dans `.env`
- [ ] Adapter `ALLOWED_HOSTS` pour inclure `*.idx.google.com`
- [ ] **IMPORTANT** : Utiliser un chemin absolu pour `DATABASE_URL` si SQLite

### 3. Installation des Dépendances
```bash
cd /home/user/VOTRE_PROJET/backend
./venv/bin/pip install -r requirements.txt
```

### 4. Migrations de Base de Données
```bash
./venv/bin/python manage.py migrate
```

### 5. Création du Site Wagtail (si utilisé)
```bash
./venv/bin/python manage.py shell << 'EOF'
from wagtail.models import Site, Page
if not Page.objects.filter(depth=1).exists():
    root = Page.add_root(title="Root", slug="root")
else:
    root = Page.objects.get(depth=1)
if not Site.objects.exists():
    Site.objects.create(
        hostname='localhost',
        port=8000,
        root_page=root,
        is_default_site=True,
        site_name='VOTRE_PROJET'
    )
EOF
```

### 6. Test de Démarrage
```bash
./venv/bin/python manage.py check
```

### 7. Lancement du Serveur
- [ ] Cliquer sur "Try Again" dans la fenêtre de prévisualisation
- [ ] Vérifier que la page s'affiche sans erreur

---

## 🚨 Pièges à Éviter

### ❌ Ne PAS faire :
1. **Utiliser Django 6.x** avec Python 3.11 → Incompatible
2. **Utiliser `django-filter==25.2`** → Nécessite Django 5.2 (inexistant)
3. **Utiliser un chemin relatif pour SQLite** dans `.env` → Le serveur de prévisualisation ne le trouvera pas
4. **Oublier d'ajouter `*.idx.google.com`** dans `ALLOWED_HOSTS` → Erreur 400
5. **Installer les dépendances avec `pip` global** → Utiliser toujours `./venv/bin/pip`

### ✅ Toujours faire :
1. **Vérifier la compatibilité Python/Django** avant de choisir les versions
2. **Utiliser des chemins absolus** pour les fichiers de base de données
3. **Tester avec `python manage.py check`** avant de lancer le serveur
4. **Créer le site Wagtail** si vous utilisez Wagtail CMS
5. **Documenter les versions exactes** dans `requirements.txt`

---

## 📚 Ressources

- [Documentation Django 5.1](https://docs.djangoproject.com/en/5.1/)
- [Documentation Wagtail 7.3](https://docs.wagtail.org/en/v7.3/)
- [Documentation Flutter](https://docs.flutter.dev/)
- [Project IDX Documentation](https://idx.dev/docs)

---

**Créé avec ❤️ pour une expérience de développement fluide sur Project IDX**
