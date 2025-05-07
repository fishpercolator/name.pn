# Turn off this guardrail because it's incompatible with Pundit best practice
# https://github.com/varvet/pundit?tab=readme-ov-file#ensuring-policies-and-scopes-are-used
Rails.application.config.action_controller.raise_on_missing_callback_actions = false