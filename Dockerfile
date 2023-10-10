# Minimal linux image is needed
FROM alpine:latest

# Install libpq and zig
RUN apk add \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \ 
  --no-cache zig

# Copy files directory to /app
COPY . /app

# Set working directory to /app
WORKDIR /app

# Build the project
RUN zig build -Doptimize=ReleaseFast

# Set the port
ENV PORT=8080
EXPOSE 8080

# Run the project with env variables
CMD ["./zig-out/bin/zapi"]
