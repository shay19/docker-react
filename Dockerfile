# Specify a BUILD Phase base image
FROM node:alpine as builder

# Specifying working directory
WORKDIR '/app'

# Install some dependencies
# Copy from the current working dir to the container
COPY package.json .
RUN npm install
COPY . .

# Default command
RUN npm run build
# Creates /app/build -> all the needed stuff for the next RUN Phase

# Specify a RUN Phase base image
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html