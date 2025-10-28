# Dockerfile para sitio web estático con Nginx
FROM nginx:alpine

# Copiar archivos del sitio web al directorio de Nginx
COPY . /usr/share/nginx/html/

# Copiar configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer puerto 80
EXPOSE 80

# Nginx se ejecutará automáticamente
CMD ["nginx", "-g", "daemon off;"]
