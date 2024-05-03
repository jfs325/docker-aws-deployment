FROM --platform=linux/amd64 golang:1.17-alpine as builder

WORKDIR /app

COPY . . 

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp main.go
# RUN go build -o myapp main.go

FROM alpine:latest 

COPY --from=builder /app/myapp /myapp

COPY --from=builder /app/html /html

CMD ["./myapp"]

EXPOSE 8000

