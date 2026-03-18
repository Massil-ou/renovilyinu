#!/bin/bash

echo "🔁 Modification du manifest.json..."

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_PATH="$PROJECT_ROOT/build/web/manifest.json"

if [ -f "$MANIFEST_PATH" ]; then
  jq '
    .name = "WinyCar" |
    .short_name = "WinyCar" |
    .display = "browser" |
    .start_url = "/" |
    .theme_color = "#28a745" |
    .background_color = "#ffffff" |
    .description = "WinyCar vous aide à trouver une voiture en Algérie : location, occasion ou neuve. Comparez les offres, consultez les annonces et trouvez votre véhicule idéal facilement."
  ' "$MANIFEST_PATH" > "$MANIFEST_PATH.tmp" && mv "$MANIFEST_PATH.tmp" "$MANIFEST_PATH"

  echo "✅ manifest.json mis à jour avec succès."
else
  echo "❌ Fichier manifest.json non trouvé : $MANIFEST_PATH"
  exit 1
fi
