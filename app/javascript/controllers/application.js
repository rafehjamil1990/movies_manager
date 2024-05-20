import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

window.initMap = function (...args) {
  const event = document.createEvent("Events");
  event.initEvent("google-maps-callback", true, true);
  event.args = args;
  window.dispatchEvent(event);
};

export { application };
