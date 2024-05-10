FROM node:19-alpine

# Copy package.json and package-lock.json if you have one
COPY package*.json /app/

WORKDIR /app

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY src /app/src

# Expose the port Next.js is running on (default is 3000)
EXPOSE 3000

# Build the Next.js app
RUN npm run build

# Start the Next.js app
CMD ["npm", "start"]
