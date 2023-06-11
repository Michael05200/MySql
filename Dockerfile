FROM mysql:latest
COPY Server.sql /docker-enterypoint-initdb.d/
docker build -t my-mysql-image
docker run -d --name my-mysql-container -p 3306:3306 my-mysql-image
