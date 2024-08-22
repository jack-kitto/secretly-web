package web

//
// import (
// 	"log"
// 	"net/http"
// )
//
// func SigninWebHandler(w http.ResponseWriter, r *http.Request) {
// 	err := r.ParseForm()
// 	if err != nil {
// 		http.Error(w, "Bad Request", http.StatusBadRequest)
// 		return
// 	}
//
// 	// name := r.FormValue("name")
// 	// email := r.FormValue("email")
//
// 	// Check if the request is an HTMX request
// 	if r.Header.Get("HX-Request") == "true" {
// 		// Render the video background template
// 		component := VideoBackground()
// 		err = component.Render(r.Context(), w)
// 		if err != nil {
// 			http.Error(w, err.Error(), http.StatusInternalServerError)
// 			log.Printf("Error rendering video background: %v", err)
// 			return
// 		}
// 		return
// 	}
//
// 	// Render the sign-in form with the hello component
// 	// err = component.Render(r.Context(), w)
// 	if err != nil {
// 		http.Error(w, err.Error(), http.StatusInternalServerError)
// 		log.Printf("Error rendering hello component: %v", err)
// 		return
// 	}
// }
//
// func ToggleAccordion(w http.ResponseWriter, r *http.Request) {
// 	item := AccordionItemData{}
// 	item.decodeParams(r)
//
// 	component := AccordionItem(item)
// 	err := component.Render(r.Context(), w)
// 	if err != nil {
// 		http.Error(w, err.Error(), http.StatusInternalServerError)
// 		log.Printf("Error toggling the accordion item: %v", err)
// 		return
// 	}
// 	return
// }
