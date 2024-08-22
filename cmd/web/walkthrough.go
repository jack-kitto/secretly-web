package web

import (
	"fmt"
	"net/http"
)

func (item AccordionItemData) descriptionStyles() string {
	if item.isOpen {
		return "max-h-60  "
	}
	return "max-h-0"
}

func (item AccordionItemData) getIsOpen() string {
	if item.isOpen {
		return "true"
	}
	return "false"
}

func (item AccordionItemData) chevronStyles() string {
	if item.isOpen {
		return "-rotate-90"
	}
	return ""
}

type AccordionItemData struct {
	title       string
	description string
	command     string
	isOpen      bool
}

func (item *AccordionItemData) decodeParams(r *http.Request) {
	if item == nil {
		panic("invalid item given to decode into AccordionItemData")
	}
	item.title = r.URL.Query().Get("title")
	item.description = r.URL.Query().Get("description")
	item.command = r.URL.Query().Get("command")
	item.isOpen = r.URL.Query().Get("isOpen") == "true"
}

func (item AccordionItemData) encodeParams() string {
	return fmt.Sprintf("title=%s&description=%s&isOpen=%s&command=%s",
		item.title,
		item.description,
		item.getIsOpen(),
		item.command,
	)
}

func installCLIItem() AccordionItemData {
	return AccordionItemData{
		title:       "Install the CLI",
		description: "Power up your terminal! ⚡️ Get our CLI for lightning-fast secret management. One command away from secure coding bliss.",
		command:     "go install github.com/jack-kitto/secretly-cli/v1.0.0",
		isOpen:      false,
	}
}

func createProjectItem() AccordionItemData {
	return AccordionItemData{
		title:       "Create a project",
		description: "Your secrets need a home 🏠 Set up a cozy project space. Name it, tag it, make it yours. Organisation made simple. <br /> Run this command from one of your projects",
		command:     "secretly --token XXXX-YYYY --init",
		isOpen:      false,
	}
}

func addEnvItem() AccordionItemData {
	return AccordionItemData{
		title:       "Add your envs",
		description: "Shhh... your secrets are safe here 🤫 In Secretly, you can drag, drop, or paste your .env files anywhere on any page. We'll tuck them away securely in seconds, give it a shot!",
		command:     "secretly --token XXXX-YYYY --init",
		isOpen:      false,
	}
}
