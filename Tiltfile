load('ext://helm_resource', 'helm_resource', 'helm_repo')
load('ext://podman', 'podman_build')
load('ext://secret', 'secret_from_dict')
load('ext://syncback', 'syncback')
load('ext://uibutton', 'cmd_button')

# Set up secrets with defaults for development
k8s_yaml(secret_from_dict('name-pn-tiltfile', inputs = {
  'postgres-password' : os.getenv('POSTGRES_PASSWORD', 's3sam3'),
  'jwt-secret': os.getenv('JWT_SECRET', 'JWT_SECRET=8139a4837740e8ca5aa6809fb87912605d4ad652cb247c30096eb62413812375d4fa906bb0bee9c3aa3663b814681af7e0e68dc1a8d59f13034ddd24f7a4fefb'),
}))

# Use Helm to spin up postgres
helm_repo('bitnami', 'https://charts.bitnami.com/bitnami')
helm_resource(
  name='name-pn-postgresql',
  chart='bitnami/postgresql',
  flags=[
      '--version=^14.0',
      '--set=image.tag=16',
      '--set=global.postgresql.auth.existingSecret=name-pn-tiltfile',
  ],
  labels=['database'],
  resource_deps=['bitnami'],
)

# The Rails app itself is built and served by app.yaml
podman_build('name-pn', '.', 
  ignore=['log', 'tmp'],
  live_update=[
    fall_back_on(['./config', './Containerfile', './k8s.yaml']),
    sync('.', '/rails'),
    run('bundle', trigger=['./Gemfile', './Gemfile.lock']),
    run('yarn', trigger=['./package.json', './yarn.lock']),
    run('yarn build', trigger=['./app/javascript']),
    run('yarn build:css', trigger=['./app/assets/stylesheets']),
])
k8s_yaml('k8s.yaml')
k8s_resource('name-pn', 
  labels=['app'],
  resource_deps=['name-pn-postgresql'],
  port_forwards='3000:3000'
)
syncback('sync lockfiles', 'deploy/name-pn', '/rails/', 
  rsync_options=[
    '--include=db/', '--include=db/schema.rb',
    '--include=Gemfile.lock', '--include=yarn.lock', '--exclude=*'
  ]
)
syncback('sync logs & test results', 'deploy/name-pn', '/rails/',
  rsync_options=[
    '--include=log/**', '--include=tmp/', '--include=tmp/capybara**',
    '--exclude=*'
  ]
)
cmd_button('name-pn:db-migrate',
  argv=['./bin/tilt-run', 'rails', 'db:migrate'],
  resource='name-pn',
  icon_name='engineering',
  text='Run migrations',
)
cmd_button('name-pn:db-reset',
  argv=['./bin/tilt-run', 'rails', 'db:seed:replant'],
  resource='name-pn',
  icon_name='restart_alt',
  text='Reset database',
  requires_confirmation=True,
)
