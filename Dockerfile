FROM node:18-alpine

ENV NODE_ENV=production

# 1. Install system utilities required for compilation
RUN apk add --upgrade --no-cache python3 make g++

WORKDIR /app

# 2. Copy dependency configuration files
COPY package.json pnpm-lock.yaml* ./

# 3. Install pnpm globally and install production dependencies
RUN npm install -g pnpm && pnpm install --prod --frozen-lockfile

# 4. Copy the remaining source files into the container
COPY . .

# 5. Dynamic port compatibility 
EXPOSE 8000/tcp

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
