package main

import (
	"log"
	"net/http"
	"os"
	"os/exec"
	"strconv"

	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	http.HandleFunc("/", handler)

	port := os.Getenv("PORT")
	//certFile := os.Getenv("HTTPS_CERT_FILE")
	//keyFile := os.Getenv("HTTPS_KEY_FILE")
	//log.Fatal(http.ListenAndServeTLS(":"+port, certFile, keyFile, nil))
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	token := os.Getenv("API_TOKEN")
	if r.Header.Get("Authorization") != token {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	number := r.URL.Query().Get("number")
	volume := r.URL.Query().Get("volume")

	if !isValidNumber(number) || !isValidVolume(volume) {
		http.Error(w, "Invalid parameters", http.StatusBadRequest)
		return
	}

	scriptPath := os.Getenv("SHELL_SCRIPT_PATH")
	cmd := exec.Command("/bin/sh", scriptPath, number, volume)
	output, err := cmd.Output()
	if err != nil {
		http.Error(w, "Error executing script", http.StatusInternalServerError)
		return
	}

	w.Write(output)
}

func isValidNumber(number string) bool {
	num, err := strconv.Atoi(number)
	return err == nil && num >= 1 && num <= 9999
}

func isValidVolume(volume string) bool {
	vol, err := strconv.Atoi(volume)
	return err == nil && vol >= 1 && vol <= 100
}
