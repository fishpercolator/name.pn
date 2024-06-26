// Start Turbolinks and UJS
import UJS from "@rails/ujs";
import Turbolinks from "turbolinks";
UJS.start();
Turbolinks.start();

// Cocoon
import "@kollegorna/cocoon-vanilla-js";

// Serviceworker
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
  .then(function(reg) {
    console.log('[Page] Service worker registered!');
  });
}

// Start Stimulus
import "./controllers";
