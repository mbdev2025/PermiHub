# 🚀 PermiHub - Monorepo Full-Stack

> **Application mobile de gestion de permis avec backend Django et frontend Flutter**

## 📂 Structure du Projet

```
PermiHub/
├── backend/          # Django REST API + Wagtail CMS
├── mobile/           # Application Flutter (iOS/Android)
└── .idx/             # Configuration Project IDX
```

---

## 🛠️ Stack Technique

### Backend
- **Django 5.1.15** - Framework web Python (Optimisé pour Python 3.11 / IDX)
- **Django REST Framework 3.16.1** - API REST
- **Wagtail CMS 7.3** - Gestion de contenu
- **JWT Authentication 5.5.1** - Authentification sécurisée
- **Stripe 14.3.0** - Paiements
- **Celery 5.6.2 + Redis 7.1.0** - Tâches asynchrones (Services IDX activés)
- **PostgreSQL / SQLite** - Base de données
- **Whitenoise 6.11.0** - Fichiers statiques
- **django-storages 1.14.6** - S3/Storage API
- **drf-spectacular 0.29.0** - OpenAPI 3 docs
- **playwright 1.58.0** - Web automation/scraping
- **pytest 9.0.2** - Tests unitaires et d'intégration

### Mobile
- **Flutter 3.2+** - Framework mobile cross-platform
- **Riverpod ^2.5.1** - State management
- **Dio ^5.4.0** - Client HTTP
- **Go Router ^13.2.0** - Navigation

### Design & UI (AI Driven)
- **Google Stitch (IA Design)** - Génération de UI et prototypage rapide via Gemini.
- **Figma** - Collaboration design et export d'assets.
- **Material Design 3** - Système de composants UI.

---

## 🚀 Démarrage Rapide

> **⚠️ IMPORTANT** : Ce projet supporte **deux modes de développement**

### 🌐 Mode 1 : Project IDX (Recommandé)
1. Ouvrez le projet dans [Project IDX](https://idx.google.com).
2. **Setup Automatique** : Le fichier `.idx/dev.nix` configure tout (Python, Redis, Postgres, Venv, Migrations).
3. **Services** : Redis et Postgres démarrent tout seuls.
4. ✅ Accédez à votre API sur le port 8000 !

📚 **Documentation complète** : [.idx/STACK_REFERENCE.md](.idx/STACK_REFERENCE.md)

---

### 💻 Mode 2 : Développement Local (Production-ready)
**Installation classique sur votre machine**

#### Prérequis
- Python 3.11+ (⚠️ Django 6.x nécessite Python 3.12+)
- PostgreSQL (optionnel, SQLite par défaut)
- Redis (pour Celery)
- Flutter 3.2+
- Git

### 1. Backend Django

⚠️ **Important** : Ce projet utilise 2 fichiers de dépendances :
- `requirements.txt` → Python 3.12+ (Antigravity, local, production)
- `requirements-idx.txt` → Python 3.11 (Project IDX uniquement)

📚 Voir [backend/REQUIREMENTS.md](backend/REQUIREMENTS.md) pour plus de détails.

```bash
cd backend

# Créer l'environnement virtuel
python3 -m venv venv
source venv/bin/activate  # Sur Windows: venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt

# Lancer les migrations
python manage.py migrate

# Créer un superutilisateur
python manage.py createsuperuser

# Démarrer le serveur
python manage.py runserver 0.0.0.0:8000
```

**Endpoints disponibles** :
- Admin: http://localhost:8000/admin/
- CMS: http://localhost:8000/cms/
- API Docs: http://localhost:8000/api/docs/
- API: http://localhost:8000/api/

### 2. Mobile Flutter

```bash
cd mobile

# Installer les dépendances
flutter pub get

# Lancer l'app (iOS Simulator)
flutter run -d ios

# Lancer l'app (Android Emulator)
flutter run -d android

# Lancer l'app (Chrome)
flutter run -d chrome
```

---

## 🔗 Communication Backend ↔ Frontend

Le mobile communique avec le backend via l'API REST :

```dart
// mobile/lib/services/api_service.dart
ApiService api = ApiService();

// Exemple: Login
final response = await api.login('admin', 'password');
final token = response['access'];
api.setAuthToken(token);

// Exemple: GET request
final data = await api.get('/endpoint/');
```

---

## 📦 Modules Backend Disponibles

| Module | Description | Endpoint |
|--------|-------------|----------|
| `apps.core` | Logique métier | `/api/core/` |
| `apps.payments` | Stripe | `/api/payments/` |
| `apps.automation` | n8n | - |
| `apps.scrapers` | Web scraping | - |

---

## 🔐 Authentification

Le système utilise JWT (JSON Web Tokens) :

1. **Login** : `POST /api/token/`
   ```json
   {
     "username": "admin",
     "password": "password"
   }
   ```

2. **Response** :
   ```json
   {
     "access": "eyJ0eXAiOiJKV1QiLCJhbGc...",
     "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
   }
   ```

3. **Utilisation** :
   ```
   Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
   ```

---

## 🌐 Déploiement

### Backend
- **Render** : `render.yaml` (à créer)
- **AWS / GCP** : Docker + Kubernetes
- **Heroku** : `Procfile` (à créer)

### Mobile
- **iOS** : App Store Connect
- **Android** : Google Play Console

---

## 📝 Variables d'Environnement

Créer un fichier `.env` dans `backend/` :

```env
DEBUG=True
SECRET_KEY=your-secret-key
ALLOWED_HOSTS=localhost,127.0.0.1

# Database
DATABASE_URL=sqlite:///db.sqlite3

# Stripe
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...

# n8n
N8N_BASE_URL=http://localhost:5678
N8N_API_KEY=your-api-key
```

---

## 🤝 Contribution

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

---

## 📄 Licence

MIT License - voir le fichier LICENSE

---

## 👨‍💻 Auteur

**MBDev2025**

---

**Bon développement ! 🚀**
