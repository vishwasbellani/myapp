# Use an official Nginx image
FROM nginx:alpine

# Copy the HTML file to the Nginx server
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf
