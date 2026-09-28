# Run using bin/ci

CI.run do
  step "Setup", "bin/setup --skip-server"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Bun audit", "bun audit"
  step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Types: TypeScript", "bun run check-types"
  step "Assets", "bun run build:css && bun run build"

  step "Tests: RSpec", "bin/rspec"
  step "Tests: Spinach", "bin/spinach"
end
