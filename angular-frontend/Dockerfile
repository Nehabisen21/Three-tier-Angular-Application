# Use an official Node.js runtime as a parent image
FROM node:18-alpine as build

# Set the working directory in the container to /app
WORKDIR /app

# Copy source code to the working directory in the container
COPY . .

# Install dependencies
RUN npm install -g @angular/cli@14.2.1

# Build the Angular app for production
RUN npm install
RUN npm run build        

# Use Nginx to serve the app
FROM nginx:alpine   

# Copy the built app from the previous stage to Nginx's html directory
COPY --from=build /app/dist/angular-frontend/ /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server to serve application on all hosts
CMD ["nginx", "-g", "daemon off;"]
