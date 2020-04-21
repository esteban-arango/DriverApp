
# Driver App!

## Installation

### 1 - Install the gems.

```sh
$ bundle install
```

### 2 - Edit database config file
**PATH:** config/database.yml
```sh
development:
  adapter: postgresql
  encoding: unicode
  database: driver_app_development
  host: localhost
  pool: 5
  username: my_username
  password: my_password
```

### 3 - Create database / Run migrations / Run seeds

```sh
$ rake db:setup
```

### 4 - Run server
```sh
$ shotgun
```

### [Optional] Run tests
```sh
$ rspec spec
```

## API Documentation
https://documenter.getpostman.com/view/11148594/Szf7zSTA

## Heroku App
https://driver-app-test.herokuapp.com/