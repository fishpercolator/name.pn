# name.pn

A Rails 8 app. The UI is Tailwind v4 + daisyUI 5, rendered with Phlex.

## Ethos

If it's available upstream, don't reinvent the wheel. Prefer a gem, a daisyUI class or a browser feature over code of our own.

## Code style

- DRY and beautiful above all. Break code into tiny, well-named methods wherever the code can't carry its meaning alone.
- Few comments. Wanting to write one is a smell: extract a method or rename something instead.
- Aim for design consistency, not parity with the old UI. When two things look different for no reason, reuse one component for both.

## Views and components

Views live in `app/views` under the `Views` namespace. Components live in `app/components` under `Components`. Both inherit from `Components::Base`.

There are three tiers of component:

| Tier | Namespace | What goes there |
|------|-----------|-----------------|
| daisyUI kit | `Components::Daisy` | One thin class per daisyUI primitive (`Button`, `Menu`, `Navbar`…) |
| UI kit | `Components::UI` | name.pn's own design elements (`Icon`, `SiteNavbar`, `CloseButton`…) |
| Feature | `Components::<Area>` | One-offs belonging to a single area. Rendered explicitly with `render`, not kits |

Both kits are included in `Components::Base`, so their components are called like methods: `Button(variant: :primary) { t('.save') }`.

### Phlex idioms

- **Builders.** Slots are methods that take a block, and are yielded to the caller: `Navbar { |n| n.brand { logo } }`. Use `vanish(&)` to collect the slots, then render them in a fixed order.
- **`grab`** for keyword arguments that are Ruby keywords (`class:`).
- **`mix`** to merge caller attributes into our defaults. Accept `**attributes` and pass them through.
- **`render?`** for components that sometimes render nothing (`FlashMessages`, `Analytics`).
- **Variants** map to daisyUI modifiers through frozen hashes of literal class names. Tailwind scans `.rb` files, so never build class names by interpolation.
- Rails helpers come in through `Phlex::Rails::Helpers::*` modules. Register other helpers with `register_output_helper` or `register_value_helper`.

### Layouts and rendering

- Layouts are Phlex classes in `Views::Layouts`, set with `layout -> { Views::Layouts::X }`. They wrap Phlex views, any remaining HAML views, and the Markdown pages alike.
- Views reach the layout only through `content_for` and meta-tags.
- Phlexible's `ImplicitRender` renders `Views::<ControllerPath>::<Action>` when an action doesn't render.
- Content pages are Markdown under `app/views/pages`, served by `PagesController` (high_voltage).

### i18n

- Views use lazy keys. `Views::Home::UserHome` looks up `t('.title')` at `home.user_home.title`.
- Components use `components.<kit>.<name>`, for example `components.ui.site_navbar.about`.

## Tests

The suite is deliberately slim.

- Spinach features are the end-to-end safety net. Keep the BEM-style hook classes they rely on (`.site-navbar`, `.dashboard-card__edit`, `.page-title`…) on whichever component renders those elements.
- Add specs only for behaviour that is ours and not obvious. Don't re-test Rails, Phlex, Tailwind, daisyUI or the browser, and don't write specs for plain markup.

Run `bundle exec rspec` and `bin/spinach`. Build assets with `bun run build:css && bun run build`.

## Pull requests

Make stacked PRs, one area each, each one reviewable on its own. Every branch in a stack must pass the suite.
