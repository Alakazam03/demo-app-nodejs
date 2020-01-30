
# My first docker file.
FROM node:latest
MAINTAINER Vaibhav Aggarwal (XXXXXX@gmail.com)

RUN echo "Tryin to build demo application"
COPY . /var/www 
WORKDIR /var/www
RUN npm install
EXPOSE 3000
ENTRYPOINT ["npm","start"]