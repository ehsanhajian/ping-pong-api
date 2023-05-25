# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install --production

# Copy the application code to the working directory
COPY . .

# Expose the port that the application will listen on
EXPOSE 3000

# Set the entrypoint command to run the application
CMD ["npm", "start"]

