# name.pn

This is the documentation for maintainers and developers of the name.pn web app.

This app follows the [Twelve-Factor](https://12factor.net/) specification, and this should be kept in mind when developing for it.

## Configuration

The app is configured using environment variables. On Heroku these can be configured using the `heroku:config` command, and on your development environment they can be added to `config/application.yml` as described in the [Figaro](https://github.com/laserlemon/figaro) documentation.

Variables that can be used to configure the app are:

* **RAILS_MAX_THREADS**: Number of threads the puma server will use
* **DOMAIN_NAME**: The canonical domain name of the site.
* **DOMAIN_IN_EMAIL_LINKS**: Override the above for email links specifically (e.g. if you need to add a port number or email links have a short domain name). Leave unset to use DOMAIN_NAME.
* **EMAIL_FROM**: The name and email address that will be used for 'From' in emails sent by this platform. Make sure the DKIM & SPF settings are correct for this domain with respect to your email sending service (e.g. SendGrid; see below).
* **AWS_ACCESS_KEY_ID** / **AWS_SECRET_ACCESS_KEY** / **AWS_REGION** / **S3_BUCKET**: Creds for a user who has SES access to send mail and S3 permission to read/write the given bucket.
* **GA_ID**: Google Analytics ID
* **BUTTONDOWN_API_KEY**: If set, enables the Buttondown mailing list integration on the user's settings page and allows them to opt in when creating an account.
* **JWT_SECRET**: A secret (e.g. generated with `rails secret`) used in signing of JWT keys used with the name.pn public API.

## name.pn Development environment

### Installation

The development environment is a [Dev Container](https://containers.dev/). Open this repo in VS Code (with the Dev Containers extension) and choose *Reopen in Container*, or use any other tool that supports Dev Containers. This builds a container with Ruby, Bun, Chromium (for JavaScript tests) and the Heroku CLI, alongside a PostgreSQL container, and runs [`bin/setup`](bin/setup) to install dependencies and prepare the database.

Once it's built, start the server and asset watchers from a terminal inside the container:

```
bin/dev
```

The web interface is then available at <http://localhost:3000>.

The [`db/seeds.rb`](db/seeds.rb) includes an admin user and the three most common sets of pronouns. Look in that file for the password.

### Usage and tips

Your working copy is mounted into the container, so lockfiles, migrations, `db/schema.rb` and generated files all land directly on your host.

After pulling changes, run `bin/setup --skip-server` to install new dependencies and run any pending migrations.

You can completely wipe out the DB and replace it with the contents of `db/seeds.rb` at any time with `bin/rails db:seed:replant`.

Optional secrets such as `BUTTONDOWN_API_KEY` or `DD_API_KEY` can be put in `config/application.yml` (which is gitignored). Default development values for the database and `JWT_SECRET` are set in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json), and the services are defined in [`.devcontainer/compose.yaml`](.devcontainer/compose.yaml).

## Deploying to Heroku

The app already conforms to the Twelve-Factor specification and has a Procfile with all the information Heroku needs to get going.

You'll need the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed to run these commands.

The [apt buildpack](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-apt) is used to install libvips, which is a prerequisite of the default ActiveStorage configuration for 7+.

To deploy it to Heroku, you can do:

```sh
cd ~/path/to/name.pn
# Replace name_pn with the name of the new heroku app
heroku apps:create --region eu name-pn
heroku buildpacks:add --index 1 heroku-community/apt
git push heroku main
```

The app should install all its dependencies and create the database automatically.

To get a Rails console on Heroku (e.g. for assigning the admin role to a user):

```sh
heroku run rails c
````

To deploy a new version:

```sh
git push heroku main
```

Or you can set up automatic deploys through the Heroku dashboard. If you're using GitHub & Codeship you can integrate this with your Codeship CI, so the new version is only deployed if the tests pass.

## GitHub Actions CI

The app is configured for continuous integration using [GitHub Actions](https://github.com/features/actions). There are two workflows:

* `audits`: runs a security audit on the gem & yarn dependencies
* `tests`: sets up a vaguely production-like environment and runs the rspec & spinach tests on it

No special configuration should be necessary - just using GitHub for this repo should be enough to enable the actions on every push.

If tests fail, screenshots are taken and uploaded to the test artifacts, which may be helpful in debugging.

If you're using Heroku it's a good idea to set it to only allow automatic deploys after CI passes.

## Features

### Rails

This is a [Rails](https://rubyonrails.org/) 8.x application, and comes with all the usual Rails stuff, plus the following additional important components.

### Bulma UI

The user interface is derived from [Bulma](https://bulma.io/documentation/), in its modular Sass mode. The CSS is compiled in Webpack from the `app/javascript/scss/application.scss` file and everything it includes. Remember to include Bulma features before you use them.

### TypeScript

Frontend TypeScript is based on the [Stimulus](https://stimulusjs.org/) framework. You can create a new TS controller by adding a file to `app/javascript/controllers` and then naming that controller in your HTML by adding a `data-controller` attribute to the parent element of the UI feature you want to control.

TypeScript is bundled using [esbuild](https://esbuild.github.io/) (via jsbundling-rails) and is currently configured to transpile to target browsers with support for es2020 and above, even if you use JS features that are newer than this version.

### Haml

Most web views are written in the concise [Haml](http://haml.info/) templating language. This is a concise version of HTML but should be instantly familiar to anyone who knows HTML.

### Devise

User management and authorization is provided by [Devise](https://github.com/plataformatec/devise) and is subject to all the documentation there.

### Active Admin

The administration interface is based on [Active Admin](https://activeadmin.info/) and is accessible on your site at the `/admin` URL.

You will need to be signed in as a user with role `:admin` to access the admin interface. If you need to assign this role to an existing user from the Rails console you can do it like this:

```ruby
User.find_by(email: 'admin@example.com').update(role: :admin)
```

### Pundit

All controller actions are authorized by [Pundit](https://github.com/varvet/pundit) policies. This allows us to ensure only the right users are allowed to do the right things at any given time.

Policies are located in `app/policies` and can be applied using the `policy_scope` method (for indexes) and the `authorize` method (for other controller actions). There are some guards to ensure these methods are called. If you write a new controller action that definitely doesn't need authorization, you can skip these: see the `HomeController` for an example.

### Simple form

Forms are normally managed by [Simple Form](https://github.com/plataformatec/simple_form), with a custom integration into the Bulma widget set. The customizations are in the `config/initializers/simple_form_bulma.rb` file.

### Meta tags

Meta tags are automatically provided by the [MetaTags](https://github.com/kpumuk/meta-tags) gem.

Titles for pages are normally set in the views using the `title` helper with an I18n string called `title` at an appropriate place on the page; for example:

    = title t('.title')

### Testing: RSpec & Spinach

Unit tests, API tests (if any) and policy tests are all done in regular rspec. All the config can be found in `spec/spec_helper.rb` and `spec/rails_helper.rb`.

To run these tests:

    ./bin/rspec

Integration tests are written in [Spinach](http://codegram.github.io/spinach/), using the acceptance criteria (in Gherkin format) in the `features/` directory. Spinach is extremely similar to Cucumber, but encourages the use of one-time steps which are scoped to a specific feature.

The development environment integrates a headless Chromium browser, which can be used to test JavaScript. If you want to use this, just add the `@javascript` tag to the feature and it will be automatically enabled in Capybara.

To run these tests:

    ./bin/spinach

### Audit

[Bundler Audit](https://github.com/rubysec/bundler-audit) is a tool that looks for security advisories against any of the gems in your Gemfile. It's recomended to run this regularly (such as in the Codeship CI) and update the gems when it reports issues.

[improved-yarn-audit](https://www.npmjs.com/package/improved-yarn-audit) does the same things for the JavaScript packages and is configured to run as part of
the Codeship steps. There's an `.iyarc` file for configuring exceptions.

### Datadog

The app is configured to work with [Datadog](https://www.datadoghq.com/) for tracing/debugging, including correlation of logs and traces.

To get this working in development, you'll need an account (a free plan one will do) and an API key. Add `DD_API_KEY` to your `config/application.yml` and the rest should sort itself out.

To get it working in Heroku, you'll need to follow the [buildpack](https://docs.datadoghq.com/agent/basic_agent_usage/heroku/) instructions for APM and the [log drain](https://docs.datadoghq.com/logs/guide/collect-heroku-logs/) instructions for logs.
