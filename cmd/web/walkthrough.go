package web

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

func (item WalkthroughItemData) descriptionStyles() string {
	// if item.isOpen {
	// 	return " max-h-60  "
	// }
	return " max-h-0"
}

func (item WalkthroughItemData) getHideCommand() string {
	if item.hideCommand {
		return "true"
	}
	return "false"
}

func (item WalkthroughItemData) getIsOpen() string {
	if item.isOpen {
		return "false"
	}
	return "true"
}

func (item WalkthroughItemData) chevronStyles() string {
	if item.isOpen {
		return "-rotate-90"
	}
	return ""
}

type WalkthroughItemData struct {
	title       string
	description string
	command     string
	isOpen      bool
	hideCommand bool
}

func (i *WalkthroughItemData) Print() {
	if i == nil {
		panic("Missing param i AccordionItemData")
	}
	res, err := json.Marshal(i)
	if err != nil {
		panic(err)
	}
	log.Print(string(res))
}

func (item *WalkthroughItemData) decodeParams(r *http.Request) {
	if item == nil {
		panic("invalid item given to decode into AccordionItemData")
	}
	item.title = r.URL.Query().Get("title")
	item.description = r.URL.Query().Get("description")
	item.command = r.URL.Query().Get("command")
	item.isOpen = r.URL.Query().Get("isOpen") == "true"
	item.hideCommand = r.URL.Query().Get("hideCommand") == "true"
}

func (item WalkthroughItemData) encodeParams() string {
	return fmt.Sprintf("/toggle-accordion?title=%s&description=%s&isOpen=%s&command=%s&hideCommand=%s",
		item.title,
		item.description,
		item.getIsOpen(),
		item.command,
		item.getHideCommand(),
	)
}

func installCLIItem() WalkthroughItemData {
	return WalkthroughItemData{
		title:       "Install the CLI",
		description: "Power up your terminal! ⚡️ Get our CLI for lightning-fast secret management. One command away from secure coding bliss.",
		command:     "go install github.com/jack-kitto/secretly-cli/v1.0.0",
		hideCommand: false,
		isOpen:      false,
	}
}

func createProjectItem() WalkthroughItemData {
	return WalkthroughItemData{
		title:       "Create a project",
		description: "Your secrets need a home 🏠 Set up a cozy project space. Name it, tag it, make it yours. Organisation made simple. Run this command from one of your projects",
		command:     "secretly --token XXXX-YYYY --init",
		isOpen:      false,
		hideCommand: false,
	}
}

func addEnvItem() WalkthroughItemData {
	return WalkthroughItemData{
		title:       "Add your envs",
		description: "Shhh... your secrets are safe here 🤫 In Secretly, you can drag, drop, or paste your .env files anywhere on any page. We'll tuck them away securely in seconds, give it a shot!",
		command:     "secretly --token XXXX-YYYY --init",
		isOpen:      false,
		hideCommand: true,
	}
}

func ToggleAccordion(w http.ResponseWriter, r *http.Request) {
	item := WalkthroughItemData{}
	item.decodeParams(r)

	component := AccordionItem(item)

	err := component.Render(r.Context(), w)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		log.Printf("Error toggling the accordion item: %v", err)
		return
	}
	return
}
