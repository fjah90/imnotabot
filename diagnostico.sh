#!/bin/bash

echo "=========================================="
echo "DIAGNÓSTICO DE DESPLIEGUE - imnotabot.879.ai"
echo "=========================================="
echo ""

echo "1. Verificando si Traefik está corriendo..."
docker ps | grep traefik
echo ""

echo "2. Verificando contenedor imnotabot-landing..."
docker ps | grep imnotabot
echo ""

echo "3. Verificando red 879_web..."
docker network ls | grep 879_web
echo ""

echo "4. Verificando si el contenedor está en la red correcta..."
docker network inspect 879_web | grep -A 5 imnotabot
echo ""

echo "5. Verificando etiquetas de Traefik en el contenedor..."
docker inspect imnotabot-landing --format='{{range $key, $value := .Config.Labels}}{{$key}}={{$value}}{{"\n"}}{{end}}' | grep traefik
echo ""

echo "6. Intentando resolver DNS..."
nslookup imnotabot.879.ai 8.8.8.8 || echo "DNS no resuelve"
echo ""

echo "7. Verificando si el puerto 80 responde dentro del contenedor..."
docker exec imnotabot-landing wget -O- http://localhost 2>/dev/null | head -n 5 || echo "No responde"
echo ""

echo "8. Últimos logs de Traefik (si existe)..."
docker logs traefik --tail 20 2>/dev/null || echo "No se encontró contenedor Traefik"
echo ""

echo "=========================================="
echo "FIN DEL DIAGNÓSTICO"
echo "=========================================="

