## End-to-End Angular Application Deployment using Docker
- This is a three-tier angular an application written in Java.


### PRE-REQUISITES FOR THIS PROJECT:
- AWS Account
- AWS Ubuntu EC2 instance (t2.medium)
- Install Docker
- Install docker compose
#
### DEPLOYMENT:
| Deployments    | Paths |
| -------- | ------- |
| Deployment using Docker and Networking | <a href="#Docker">Click me </a>     |

#
### STEPS TO IMPLEMENT THE PROJECT
- **<p id="Docker">Deployment using Docker</p>**
  - Clone the repository
  ```bash
  git clone -b DevOps https://github.com/DevMadhup/Three-tier-Angular-Application.git
  ```
  #
  - Install docker, docker compose and provide neccessary permission
  ```bash
  sudo apt update -y

  sudo apt install docker.io docker-compose-v2 -y

  sudo usermod -aG docker $USER && newgrp docker
  ``` 
  #
  - Move to the cloned repository
  ```bash
  cd Three-tier-Angular-Application/spring-backend/
  ```
  #
  - Build the Dockerfile
  ```bash
  docker build -t spring-backend .
  ```

  #
  - Create a docker network
  ```bash
  docker network create three-tier
  ```
  #
  - Run MYSQL container
  ```bash
  docker run -itd --name mysql -e MYSQL_ROOT_PASSWORD=springbackend -e MYSQL_DATABASE=springbackend --network=three-tier mysql
  ```
  #
  - Run Backend Application container
  ```bash
  docker run -itd --name spring-backend --network=three-tier -p 8080:8080 spring-backend
  ```
  #
  - Verify deployment
  ```bash
  docker ps
  ```
  # 
  - Open port 8080 of your AWS instance and access your backend API application
  ```bash
  http://<public-ip>:8080/api/v1/workers
  ```

  - Now, go to angular-frontend directory and build frontend app using docker

  ```bash
  docker build -t angular-frontend .
  ```
  #
  - Run Frontend Application container

  ```bash
  docker run -itd --name angular-frontend --network=three-tier -p 80:80 angular-frontend
  ```
  #
  - Open your favourite browser and access your application
  ```bash
  http://<public-ip>/workers
  ```

  ### Congratulations, you have deployed the application using Docker 
  