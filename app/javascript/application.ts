// Start Turbo
import "@hotwired/turbo";

// Cocoon
import "@kollegorna/cocoon-vanilla-js";

// Serviceworker
if (navigator.serviceWorker) {
  navigator.serviceWorker.register("/serviceworker.js", { scope: "/" })
    .then(() => navigator.serviceWorker.ready)
    .then((registration) => {
      if ("SyncManager" in window) {
        (registration as any).sync.register("sync-forms");
      } else {
        console.log("[Companion]", "This browser does not support background sync.")
      }
    }).then(() => console.log("[Companion]", "Service worker registered!"))
}

// Start Stimulus
import "./controllers";
