FROM node:14.5.0-alpine

ENV PORT 3000

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Installing dependencies
COPY package*.json /app/
RUN npm install

# Copying source files
COPY . /app

# Building app
RUN npm run build
EXPOSE 3000

# Running the app
CMD ["npm", "run", "start"]