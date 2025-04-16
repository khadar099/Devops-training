Let’s assume:
•	You're using the official nginx, tomcat, and mysql images.
•	You want them to be on the same network.
•	You’ll map ports so you can access nginx and tomcat from your host.
•	For the SQL container, you’ll define a root password and a database.
Here’s the docker-compose.yml:



version: '3.8'

services:

  nginx:
  
    image: nginx:latest
    
    ports:
    
      - "8080:80"
      
    depends_on:
    
      - tomcat
      
    volumes:
    
      - ./nginx.conf:/etc/nginx/nginx.conf
      
    networks:
    
      - app-network
      

  tomcat:
  
    image: tomcat:latest
    
    ports:
    
      - "8081:8080"
      
    networks:
    
      - app-network
      

  db:
  
    image: mysql:5.7
    
    environment:
    
      MYSQL_ROOT_PASSWORD: rootpassword
      
      MYSQL_DATABASE: mydb
      MYSQL_USER: user
      MYSQL_PASSWORD: userpassword
    ports:
      - "3306:3306"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge





🔧 Overall Structure
yaml
Copy
Edit
version: '3.8'
services:
  ...
networks:
  ...
version: Specifies the Compose file format version.

services: Defines each container and its configuration.

networks: Custom network configuration so containers can communicate.

🚀 Service: nginx
yaml
Copy
Edit
nginx:
  image: nginx:latest
  ports:
    - "8080:80"
  depends_on:
    - tomcat
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf
  networks:
    - app-network
image: Uses the latest official NGINX image.

ports: Maps port 80 of the container to port 8080 on the host.

depends_on: Waits for the tomcat container to be started before this one starts (note: it doesn’t wait until Tomcat is ready, just started).

volumes: Mounts a custom NGINX configuration file from your local directory (./nginx.conf) into the container.

networks: Connects to the custom app-network.

🧰 Service: tomcat
yaml
Copy
Edit
tomcat:
  image: tomcat:latest
  ports:
    - "8081:8080"
  networks:
    - app-network
image: Uses the latest official Tomcat image.

ports: Exposes port 8080 inside the container to port 8081 on the host.

networks: Also connects to the same app-network as NGINX.

🛢️ Service: db (MySQL)
yaml
Copy
Edit
db:
  image: mysql:5.7
  environment:
    MYSQL_ROOT_PASSWORD: rootpassword
    MYSQL_DATABASE: mydb
    MYSQL_USER: user
    MYSQL_PASSWORD: userpassword
  ports:
    - "3306:3306"
  networks:
    - app-network
image: Uses MySQL version 5.7.

environment: Sets up the root password, a new database (mydb), and a user with its password.

ports: Exposes MySQL's default port 3306.

networks: Again, part of the same network, so all services can talk to each other using container names.

🌐 Networks
yaml
Copy
Edit
networks:
  app-network:
    driver: bridge
app-network: A user-defined bridge network which allows containers to communicate by their service names (e.g., nginx can reach tomcat by using http://tomcat:8080).

🧠 Summary
The app consists of:

NGINX acting as a reverse proxy or frontend.

Tomcat running a Java web app.

MySQL as the backend database.

They all share a common network, so they can communicate internally.

The app is accessible via:

NGINX on localhost:8080

Tomcat directly on localhost:8081

MySQL on localhost:3306

