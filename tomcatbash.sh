#!/bin/bash

TOMCAT_HOME="$HOME/CasinoTomcat/tomcat"
CLASSES_DIR="$TOMCAT_HOME/webapps/Casino/WEB-INF/classes"
LIB_DIR="$TOMCAT_HOME/lib"

echo "=== Arrêt de Tomcat ==="
"$TOMCAT_HOME/bin/shutdown.sh"

# Petite pause pour être sûr que Tomcat est bien arrêté
sleep 3

echo "=== Compilation des fichiers Java ==="

# Construction du classpath avec toutes les libs
CLASSPATH="$CLASSES_DIR"
for jar in "$LIB_DIR"/*.jar; do
  CLASSPATH="$CLASSPATH:$jar"
done

# Compilation
javac -cp "$CLASSPATH" "$CLASSES_DIR"/*.java

if [ $? -ne 0 ]; then
  echo "❌ Erreur de compilation"
  exit 1
fi

echo "✅ Compilation terminée avec succès"

echo "=== Démarrage de Tomcat ==="
"$TOMCAT_HOME/bin/startup.sh"

echo "🚀 Tomcat redémarré"
