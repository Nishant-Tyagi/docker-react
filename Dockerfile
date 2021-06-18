#Referencing it as a builder phase.
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
#This will install dependencies.
RUN npm install
COPY . .
RUN npm run build

#New image
FROM nginx
#port mapping. This mapping is explicitly work for elasticbeanstalk not with docker directly. Elasticbeanstalk reads this docker file and map this port for requests.
EXPOSE 80/tcp
EXPOSE 80/udp
#copy everything from specific directory of builder phase and paste it on a particular location from where ngnix will run everything.
COPY --from=builder /app/build /usr/share/nginx/html
#nginx will execute the start command automatically.
