require "./spec/support/error_pages"

Spinach.hooks.on_tag("show_exceptions") { ErrorPages.render_like_production }
Spinach.hooks.after_scenario { ErrorPages.restore }
