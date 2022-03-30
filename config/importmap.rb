# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "fitty", to: "https://ga.jspm.io/npm:fitty@2.3.6/dist/fitty.module.js"
pin "uppload", to: "https://ga.jspm.io/npm:uppload@3.2.1/dist/index.umd.js"
pin "cropperjs", to: "https://ga.jspm.io/npm:cropperjs@1.5.12/dist/cropper.js"
pin "focus-trap", to: "https://ga.jspm.io/npm:focus-trap@5.1.0/index.js"
pin "mitt", to: "https://ga.jspm.io/npm:mitt@1.2.0/dist/mitt.js"
pin "tabbable", to: "https://ga.jspm.io/npm:tabbable@4.0.0/index.js"
pin "xtend", to: "https://ga.jspm.io/npm:xtend@4.0.2/immutable.js"
pin "opus-recorder", to: "https://ga.jspm.io/npm:opus-recorder@8.0.5/dist/recorder.min.js"
pin "luminous-lightbox", to: "https://ga.jspm.io/npm:luminous-lightbox@2.4.0/es/lum.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@6.1.5/lib/assets/compiled/rails-ujs.js"
pin "@kollegorna/cocoon-vanilla-js", to: "https://ga.jspm.io/npm:@kollegorna/cocoon-vanilla-js@1.0.7/index.js"
