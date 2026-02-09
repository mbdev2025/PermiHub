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
- **Django 6.0.2** - Framework web Python
- **Django REST Framework** - API REST
- **Wagtail CMS** - Gestion de contenu
- **JWT Authentication** - Authentification sécurisée
- **Stripe** - Paiements
- **Celery + Redis** - Tâches asynchrones
- **PostgreSQL / SQLite** - Base de données

### Mobile
- **Flutter 3.2+** - Framework mobile cross-platform
- **Riverpod** - State management
- **Dio** - Client HTTP
- **Go Router** - Navigation
- **Google Fonts** - Typographie

---

## 🚀 Démarrage Rapide

### Prérequis
- Python 3.12+
- Flutter 3.2+
- Git

### 1. Backend Django

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
