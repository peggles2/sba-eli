# SBA-ELI

This application is for the SBA ELI program.

## Installation
### Requirements:
* Install asdf and asdf-ruby
  -(asdf)[https://github.com/asdf-vm/asdf]
  - `asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`
* Ruby 2.5.3
- `asdf install ruby 2.5.3`
- `asdf global ruby 2.5.3`
* Node
- `brew install node`
* Yarn
- `brew install yarn`
* Postgresql 11
  * Mac
    - Use [Postgres.app](http://postgresapp.com)

## Getting Started

If bundle is not installed, do that now:
```bash
gem install bundler
```


```bash
bundle install
bin/rails app:build
bundle exec figaro install
```

Figaro should create a `config/application.yml` file.
Copy `config/application.yml.example` to `config/application.yml` and fill in the environment variables with your own canvas configuration
If `bundle install` fails due to the pg gem run:
```bash
gem install pg -- --with-pg-config=//Applications/Postgres.app/Contents/Versions/11/bin/pg_config
```

## Run
To launch the app:
```bash
rails server
```
Then point your browser to http://localhost:3000/

## Rebuilding the Database (start from scratch)

If the need arises to rebuild your local database, run the following command

```shell
bin/rails app:rebuild
```

This command will kill all Postgres connections, drop the database, recreate the
database, run migrations, seed the database and prepare the test database. Only
works in development.

## Testing

To use guard to continuously run tests as files are saved

```shell
bundle exec guard
```

To run the test suit, run:
```
rspec
```

For more verbose output, run:
```
rspec -fd
```
