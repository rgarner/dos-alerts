# Run book

## Installation history

- Create dokku 0.17.9 droplet on Ubuntu 18.04 called `dos-alerts`
- Finish setup at its IP address
- On that server:
  - `dokku apps:create dos-alerts`
  - `sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git`
  - `dokku postgres:create dos_opportunities_production`
  - `dokku config:set dos-alerts ENV=production`
  - Once the services have been created, you then set the DATABASE_URL environment variable by linking the service, as follows:
    - `dokku postgres:link dos_opportunities_production dos-alerts`
- Locally:
  - `git remote add dokku dokku@dos-alerts:dos-alerts`
  - `git push dokku master` deploys      