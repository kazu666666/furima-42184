import { Application } from "@hotwired/stimulus"
import "./item_price";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
