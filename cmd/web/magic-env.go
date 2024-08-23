package web

import (
	"encoding/json"
	"log"
	"net/http"
)

type Secrets struct {
	Secrets map[string]string `json:"secrets"`
}

func UploadSecretsHandler(w http.ResponseWriter, r *http.Request) {
	var secrets Secrets
	err := json.NewDecoder(r.Body).Decode(&secrets)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	log.Println(secrets.Secrets)

	// Respond back with success or error message
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Secrets uploaded successfully"))
}
