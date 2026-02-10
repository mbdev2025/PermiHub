# 📦 Gestion des Dépendances

Ce projet supporte **deux environnements** avec des versions Python différentes.

---

## 🐍 Fichiers de Dépendances

### `requirements.txt` (Python 3.12+)
**Pour** : Antigravity, développement local, production

**Versions** :
- Django 6.0.2
- django-filter 25.2
- Python 3.12+ requis

**Installation** :
```bash
pip install -r requirements.txt
```

---

### `requirements-idx.txt` (Python 3.11)
**Pour** : Project IDX uniquement

**Versions** :
- Django 5.1.15
- django-filter 24.3
- Python 3.11 (via Nix)

**Installation** :
```bash
pip install -r requirements-idx.txt
```

---

## 🔄 Pourquoi Deux Fichiers ?

| Raison | Explication |
|--------|-------------|
| **Python 3.11 dans IDX** | Project IDX utilise Nix avec Python 3.11 |
| **Django 6.x nécessite Python 3.12+** | Incompatible avec Python 3.11 |
| **django-filter 25.2 nécessite Django 5.2** | Version inexistante, nécessite downgrade |

---

## ✅ Quelle Version Utiliser ?

```
Vous êtes dans Project IDX ?
  ↓
  Utilisez requirements-idx.txt

Vous êtes en local (Antigravity, serveur) ?
  ↓
  Utilisez requirements.txt
```

---

## 🚀 Configuration Automatique dans IDX

Le fichier `.idx/dev.nix` est configuré pour utiliser automatiquement `requirements-idx.txt` :

```nix
onCreate = {
  setup = ''
    cd backend
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements-idx.txt  # ← Utilise la version IDX
    python manage.py migrate
  '';
};
```

---

## 📝 Mise à Jour des Dépendances

### Pour `requirements.txt` (Python 3.12)
```bash
pip install --upgrade django
pip freeze > requirements.txt
```

### Pour `requirements-idx.txt` (Python 3.11)
```bash
# Copier requirements.txt
cp requirements.txt requirements-idx.txt

# Modifier manuellement :
# - Django==6.0.2 → Django==5.1.15
# - django-filter==25.2 → django-filter==24.3
```

---

**Dernière mise à jour** : 10 février 2026
