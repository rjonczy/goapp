# Use the official Golang image to create a build artifact.
FROM golang:1.21 as builder

# Set the Current Working Directory inside the container.
WORKDIR /app

# Copy go mod and sum files.
COPY go.mod go.sum /app/

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files do not change.
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container.
COPY . .

# Build the Go app for Linux x64.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Start from a fresh Alpine image to create a smaller final image.
FROM alpine:latest  
WORKDIR /

# Copy the pre-built binary file from the previous stage.
COPY --from=builder /app/main .

# Command to run the executable.
CMD ["/main"]
