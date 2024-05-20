import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="places"
export default class extends Controller {
  static targets = ["field"];
  connect() {
    if (typeof google != undefined) {
      this.initMap();
    }
  }

  initMap() {
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget);
  }
}
