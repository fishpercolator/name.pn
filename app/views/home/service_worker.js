function onInstall(event) {
  console.log('[Serviceworker]', "Installing!", event);
}
 
function onActivate(event) {
  console.log('[Serviceworker]', "Activating!", event);
}
 
function onFetch(event) {
  console.log('[Serviceworker]', "Fetching!", event);
}
self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);
