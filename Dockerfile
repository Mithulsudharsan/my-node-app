# Use an official Node.js image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your app will run on
EXPOSE 3000

# Command to run the app
CMD ["node", "app.js"]
