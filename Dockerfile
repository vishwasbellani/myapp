# Use an official Nginx image
FROM nginx:alpine

# Copy the HTML file and SSL certificates to the Nginx server
COPY index.html /usr/share/nginx/html/
COPY certs/nginx.crt /etc/ssl/certs/nginx.crt
COPY certs/nginx.key /etc/ssl/private/nginx.key

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf
