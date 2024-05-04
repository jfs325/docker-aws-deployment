package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	directoryPath := "./html"

	_, err := os.Stat(directoryPath)
	if os.IsNotExist(err) {
		fmt.Printf("Directory '%s' not found.\n", directoryPath)
		return
	}

	fileServer := http.FileServer(http.Dir(directoryPath))

	http.Handle("/", fileServer)

	port := 8000
	fmt.Printf("Server started at http://localhost:%d\n", port)
	err = http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
	if err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}
