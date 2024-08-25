# Use the official Go image as the base image
FROM golang:1.23.0-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache build-base curl gcompat make npm nodejs wget

# Install Templ (this is a separate RUN command)
RUN go install github.com/a-h/templ/cmd/templ@latest

# Download TailwindCSS
RUN wget https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
  && chmod +x tailwindcss-linux-x64 \
  && mv tailwindcss-linux-x64 tailwindcss

# Copy the Go modules files
COPY go.mod go.sum ./

# Download Go modules
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the application
RUN templ generate
RUN ./tailwindcss -i cmd/web/assets/css/input.css -o cmd/web/assets/css/output.css
RUN go build -o main cmd/api/main.go

# Start a new stage from scratch
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the binary from the build stage
COPY --from=build /app/main .

# Expose the port the app runs on
EXPOSE 8081

# Command to run the application
CMD ["./main"]

