// Start Turbo
import "@hotwired/turbo";

// Serve an offline page when the network is unavailable
navigator.serviceWorker?.register("/service-worker.js")

// Start Stimulus
import "./controllers";
