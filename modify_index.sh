#!/bin/bash

echo "🚗 Modification de build/web/index.html pour WinyCar..."

# On se base sur la racine du repo
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_PATH="$PROJECT_ROOT/build/web/index.html"

if [ -f "$INDEX_PATH" ]; then
  # 🔧 0) Désactiver le service worker (important pour que la version se mette à jour)
  # On supprime la balise qui charge flutter_service_worker.js
  sed -i '/flutter_service_worker\.js/d' "$INDEX_PATH"

  # 🔧 1) Titre et description
  sed -i 's|<title>.*</title>|<title>WinyCar – Trouvez une voiture en Algérie</title>|' "$INDEX_PATH"
  sed -i 's|<meta name="description" content="[^"]*">|<meta name="description" content="WinyCar vous aide à trouver une voiture en Algérie : location, occasion ou neuve. Comparez les offres et trouvez rapidement votre véhicule idéal.">|' "$INDEX_PATH"

  # 🔧 2) Mots-clés et robots (ajout après la description)
  sed -i '/<meta name="description"/a\
  <meta name="keywords" content="voiture Algérie, location voiture, voiture occasion, voiture neuve, WinyCar">\
  <meta name="robots" content="index, follow">' "$INDEX_PATH"

  # 🔧 3) Icônes
  sed -i 's|<link rel="icon"[^>]*>|<link rel="icon" type="image/png" href="assets/assets/icons/winycar-icon.png"/>|' "$INDEX_PATH"
  sed -i 's|<link rel="apple-touch-icon"[^>]*>|<link rel="apple-touch-icon" href="assets/assets/icons/winycar-icon-192.png">|' "$INDEX_PATH"

  # 🔧 4) Open Graph
  sed -i '/<meta name="robots"/a\
  <meta property="og:title" content="WinyCar – Trouvez une voiture en Algérie">\
  <meta property="og:description" content="WinyCar facilite la recherche de véhicules : location, occasion ou neuf, partout en Algérie.">\
  <meta property="og:image" content="assets/assets/icons/winycar-icon.png">\
  <meta property="og:type" content="website">' "$INDEX_PATH"

  echo "✅ index.html modifié avec succès."
else
  echo "❌ Fichier introuvable : $INDEX_PATH"
  exit 1
fi
