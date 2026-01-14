# Stage 1: Builder (Uses Go 1.25 to fix your version error)
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Install git just in case dependencies need it
RUN apk add --no-cache git

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the application
# We use ./... to find the main package automatically inside root or cmd
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/... 2>/dev/null || go build -o main .

# Stage 2: Runner (Small and Secure)
FROM alpine:latest

WORKDIR /app

# Create a non-root user (Assessment Requirement)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Install curl for healthcheck
RUN apk --no-cache add curl

# Copy the binary from builder
COPY --from=builder /app/main .

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose the application port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/health || exit 1

# Command to run the executable
CMD ["./main"]