# Three-Tier Architecture Setup

## Overview
This document provides a step-by-step guide to setting up a **Three-Tier Architecture** using:
- **Frontend:** Angular application hosted on an Ubuntu server and deployed to Amazon S3 with CloudFront CDN.
- **Backend:** Spring Boot application running on an Ubuntu server, connecting to an Amazon RDS database.
- **Database:** Amazon RDS with MariaDB to store application data.

---

## Prerequisites
### Required Infrastructure:
- **2 Ubuntu Linux Servers**:
  - Server 1: Frontend Application
  - Server 2: Backend Application
- **Amazon RDS Database** (MariaDB)
- **Amazon S3 Bucket** (To host frontend files)
- **CloudFront CDN** (To cache frontend assets and improve performance)

---

## Step 1: Set Up Amazon RDS Database
### Create an Amazon RDS Instance:
1. Log in to the AWS Console.
2. Navigate to **Amazon RDS** > **Create Database**.
3. Select **MariaDB** as the engine type.
4. Choose the instance type and configure storage as per your requirement.
5. Set **Master Username** and **Password**:
   - **Username:** `admin`
   - **Password:** `Admin123`
6. Enable **Public Accessibility** and configure security groups.
7. Click **Create Database** and wait for the instance to be available.

### Connect to RDS Instance
After creation, use the database endpoint to configure the backend.
```sh
mysql -h <rds_data_endpoint> -u admin -pAdmin123
```

---

## Step 2: Configure Backend Server
### Install MariaDB on Backend Ubuntu Server
```sh
sudo apt update
sudo apt install mariadb-server
systemctl start mariadb
systemctl enable mariadb
```

### Clone Backend Repository
```sh
git clone https://github.com/cloud-blitz/angular-java.git
```

### Configure Database
```sh
CREATE DATABASE springbackend;
GRANT ALL PRIVILEGES ON springbackend.* TO 'username'@'localhost' IDENTIFIED BY 'your_password';
sudo mysql -u username -p springbackend < springbackend.sql
```

### Verify Database Connection
```sh
mysql -h <rds_data_endpoint> -u admin -pAdmin123
show databases;
show tables;
select * from tbl_workers;
```

---

## Step 3: Setup Backend Application
### Configure Application Properties
```sh
git clone https://github.com/cloud-blitz/angular-java.git
cd spring-backend
cd src/main/resources/
vim application.properties
```

Update `application.properties` with:
```properties
spring.datasource.url=jdbc:mysql://database-1.c3ok6m0m4tt7.ap-northeast-1.rds.amazonaws.com:3306/springbackend?useSSL=false 
spring.datasource.username=admin
spring.datasource.password=Admin1234
spring.jpa.generate-ddl=true
```

### Install Java and Maven
```sh
sudo apt update
sudo apt install openjdk-8-jdk
sudo apt install maven
```

### Build and Run Backend Application
```sh
mvn clean package -Dmaven.test.skip=true
java -jar target/spring-backend-v1.jar
```

**Notes:**
- Ensure necessary permissions for `sudo` commands.
- Use compatible Java and Maven versions.
- Adjust file paths according to your project structure.

---

## Step 4: Setup Frontend Server
### Clone Frontend Repository
```sh
git clone https://github.com/cloud-blitz/angular-java.git
cd angular-java
cd angular-frontend
```

### Update API Endpoint in Angular Service
```sh
cd src/app/services/
vim worker.service.ts
```
Update `worker.service.ts` (Line 12):
```ts
private getUrl: string = "http://57.180.55.30:8080/api/v1/workers";  // Replace with your backend IP
```

### Install Node.js, NPM, and Angular CLI
```sh
sudo apt update
sudo apt install nodejs npm
node -v
npm -v
sudo npm install -g @angular/cli@14.2.1
ng --version
```

### Install Project Dependencies & Build Frontend
```sh
npm install
ng build 
```

### Serve Angular Application Locally (For Testing)
```sh
cd dist/angular-frontend
ng serve --host 0.0.0.0 --port=80
```

---

## Step 5: Deploy Frontend to AWS S3 & CloudFront
### Upload Files to S3 Bucket
1. Copy all files from `dist/angular-frontend` directory.
2. Go to the **Amazon S3** Console.
3. Create a new bucket and enable **Static Website Hosting**.
4. Upload all frontend files to the bucket.
5. Configure bucket permissions to allow public access.

### Set Up CloudFront CDN
1. Navigate to **Amazon CloudFront**.
2. Create a new distribution.
3. Select **S3 Bucket** as the origin.
4. Configure caching and distribution settings.
5. Deploy and note the **CloudFront URL**.

Your three-tier architecture is now successfully deployed with optimized performance and security!

---

## Summary
This guide walks you through setting up a **Three-Tier Architecture** with an Angular frontend, a Spring Boot backend, and an Amazon RDS database. The frontend is hosted on **S3 with CloudFront**, while the backend runs on **Ubuntu**, connecting to **RDS MariaDB**. Following these steps ensures a **scalable, secure, and high-performing** deployment.


---

The error indicates that port 8080 is already being used by another process on your machine. To resolve this issue, you can either:

Stop the process using port 8080, or

Run your application on a different port.

Here’s how you can handle both scenarios:

->

ption 1: Stop the Process Using Port 8080
Step 1: Identify the Process
Run the following command to find the process ID (PID) using port 8080:

On Linux/Mac: 
```
sudo lsof -i :8080
```

Step 2: Stop the Process
Once you have the PID, stop the process:

On Linux/Mac:
```
sudo kill -9 <PID>
```

![Alt text](Screenshot%202025-03-03%20at%205.50.52 PM.png)



