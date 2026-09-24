# name.pn

A Rails 8 app. The UI is Tailwind v4 + daisyUI 5, rendered with Phlex.

## Ethos

If it's available upstream, don't reinvent the wheel. Prefer a gem, a daisyUI class or a browser feature over code of our own.

## Code style

- DRY and beautiful above all. Break code into tiny, well-named methods wherever the code can't carry its meaning alone.
- Few comments. Wanting to write one is a smell: extract a method or rename something instead.
- Methods that subclasses override (template-method hooks such as `section_name` or `content`) are `protected`, so the class hierarchy is visible. Helpers private to one class stay `private`.
- Aim for design consistency, not parity with the old UI. When two things look different for no reason, reuse one component for both.

## Views and components

Views live in `app/views` under the `Views` namespace. Components live in `app/components` under `Components`. Both inherit from `Components::Base`.

There are four tiers of component:

| Tier | Namespace | What goes there |
|------|-----------|-----------------|
| daisyUI kit | `Components::Daisy` | One thin class per daisyUI primitive (`Button`, `Menu`, `Navbar`…) |
| UI kit | `Components::UI` | name.pn's own design elements (`Icon`, `Brand`, `CloseButton`…) |
| Shared | `Components::Shared` | Pieces used across areas that wire app state into the kits (`SiteNavbar`, `SiteHead`…) |
| Page | `Components::<Page>` | Pieces of a single page, e.g. `Components::Dashboard::NameSection` |

Only the two kits extend `Phlex::Kit`. They're included in `Components::Base`, so their components are called like methods: `Button(variant: :primary) { t('.save') }`. Shared and page components are rendered explicitly: `render Components::Shared::SiteFooter.new`.

Kit components are pure UI. They get their data through the constructor, and never read routes, `current_user`, `flash` or the environment themselves. That wiring belongs in shared components, page components or views.

### Phlex idioms

- **Code follows the shape of the page.** Use `do…end` for boxes (cards, forms, lists, wrappers) and `{}` for lines (headings, text, a single inline element), even when a box would fit on one line. It's a rule of thumb, not a law.
- **Builders.** Slots are methods that take a block, and are yielded to the caller: `Navbar { |n| n.brand { logo } }`. Use `vanish(&)` only when the slots must render in a different order from the one they were called in, or need manipulating before they render.
- **`grab`** for keyword arguments that are Ruby keywords (`class:`).
- **`mix`** to merge caller attributes into our defaults. Accept `**attributes` and pass them through.
- **`render?`** for components that sometimes render nothing (`FlashMessages`, `Analytics`).
- **Variants** map to daisyUI modifiers through a frozen hash of literal class names. Tailwind only generates classes it finds in the source, so never build class names by interpolation.
- Rails helpers come in through `Phlex::Rails::Helpers::*` modules. Register other helpers with `register_output_helper` or `register_value_helper`.

### Layouts and rendering

- Layouts are Phlex classes in `Views::Layouts`, set with `layout -> { Views::Layouts::X }`. They wrap Phlex views and the Markdown pages alike. Only the mailer layouts are ERB.
- Views reach the layout only through `content_for` and meta-tags.
- Phlexible's `ImplicitRender` renders `Views::<ControllerPath>::<Action>` when an action doesn't render.
- Content pages are Markdown under `app/views/pages`, served by `PagesController` (high_voltage).

### Forms

`Form(model:, url:, …)` takes `form_with`'s arguments, calls it, and yields itself. Views never see the Rails builder:

```ruby
Form(model: resource, scope: :user, url: user_session_path) do |form|
  form.field :email
  form.checkbox :remember_me
  form.submit t('.submit')
end
```

- `field` renders a daisyUI fieldset with its label, input, error and hint. The input type is inferred from the attribute name, or given with `as:`.
- Labels, hints and placeholders come from `helpers.label|hint|placeholder.<model>.<attribute>`, and labels fall back to `human_attribute_name`. Pass `label:` or `hint:` only for copy that belongs to one page.
- `select(attribute, choices:)` renders a select in the same kind of fieldset.
- `input` renders a bare input, for layouts without a fieldset.
- Don't pass a form into helper methods. A page helper that owns the form yields it to an inline block, the way `form_with` does: `form_card(url: …) { |form| … }` on the Devise pages, `wizard_step { |form| … }` in the profile wizard.

### i18n

- Views use lazy keys. `Views::Home::UserHome` looks up `t('.title')` at `home.user_home.title`.
- Components use `components.<tier>.<name>`, for example `components.shared.site_navbar.about`.

## Tests

The suite is deliberately slim.

- Spinach features are the end-to-end safety net. Keep the BEM-style hook classes they rely on (`.site-navbar`, `.dashboard-card__edit`, `.page-title`…) on whichever component renders those elements.
- Phlex emits no whitespace between tags, so rack_test sees adjacent elements' text run together. Match text across elements with `\s*`, as `have_card` in `features/steps/dashboard.rb` does.
- Add specs only for behaviour that is ours and not obvious. Don't re-test Rails, Phlex, Tailwind, daisyUI or the browser, and don't write specs for plain markup.

Run `bundle exec rspec` and `bin/spinach`. Build assets with `bun run build:css && bun run build`.

## Pull requests

Make stacked PRs, one area each, each one reviewable on its own. Every branch in a stack must pass the suite.
