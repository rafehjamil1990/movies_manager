import { Controller } from "@hotwired/stimulus";
import "adminlte_theme/plugins/jquery/jquery";

// Connects to data-controller="notifications"
export default class extends Controller {
  static values = {
    alertType: String,
    message: String,
    toastType: String,
  };

  connect() {
    console.log("notifications controller connected");
    $(document).Toasts("create", {
      title: this.alertTypeValue,
      autohide: true,
      delay: 5500,
      body: this.messageValue,
      class: this.toastTypeValue,
    });
  }
}
