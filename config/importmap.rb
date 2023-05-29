# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/core", under: "core"

pin "chartjs", to: 'plugins/chartjs.min.js', preload: true
pin "jquery", to: 'core/jquery.min.js', preload: true
pin "bootstrap", to: 'core/bootstrap.min.js', preload: true