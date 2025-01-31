#!/bin/bash

# Déploiement automatisé de l'API Flask sur Render

# Étape 2 : Installer l'outil Render CLI (Optionnel, si besoin de gérer via ligne de commande)
# curl -fsSL https://render.com/install.sh | bash

# Étape 3 : Configurer le fichier requirements.txt
cat <<EOL > requirements.txt
flask
gunicorn
pandas
requests
EOL

# Étape 4 : Créer le fichier Procfile pour Render
cat <<EOL > Procfile
web: gunicorn -w 4 -b 0.0.0.0:10000 brvm_invest_bot:app
EOL

# Étape 5 : Push des changements vers GitHub
git add .
git commit -m "Ajout des fichiers pour Render"
git push origin main

# Étape 6 : Aller sur Render et créer un service web
# 1. Accédez à https://dashboard.render.com/
# 2. Cliquez sur "New" > "Web Service"
# 3. Sélectionnez votre repository GitHub
# 4. Choisissez l'environnement : Python 3.x
# 5. Ajoutez `requirements.txt` dans la section Build Command
# 6. Définissez la commande de démarrage : `gunicorn -w 4 -b 0.0.0.0:10000 brvm_invest_bot:app`
# 7. Cliquez sur "Create Web Service"

# Étape 7 : Déployer la Landing Page sur Netlify
# 1. Accédez à https://www.netlify.com/
# 2. Glissez-déposez le fichier landing_page_brvm.html pour héberger la page
# 3. Copiez l'URL Netlify et mettez-la à jour dans le script de fetch() de la page

# Étape 8 : Tester l'API et la Landing Page
echo "Déploiement terminé ! Accédez à l'API Render et à la Landing Page Netlify."
