Verb API
======

[![Build Status](https://travis-ci.org/JonathanPorta/verb-api.svg?branch=master)](https://travis-ci.org/JonathanPorta/verb-api)
[![Coverage Status](https://coveralls.io/repos/JonathanPorta/verb-api/badge.png)](https://coveralls.io/r/JonathanPorta/verb-api)
[![Code Climate](https://codeclimate.com/github/JonathanPorta/verb-api/badges/gpa.svg)](https://codeclimate.com/github/JonathanPorta/verb-api)
[![Dependency Status](https://gemnasium.com/JonathanPorta/verb-api.svg)](https://gemnasium.com/JonathanPorta/verb-api)

Server       | Watch/LiveReload/Tests/Lint
-------------|----------------------------
`$ rails s`  | `$ guard`

When using the `$ guard` file-watcher, installing [LiveReload Extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei) for Chrome will automatically refresh the browser on file-changes.

First-time install
------------------

Install system dependencies:
* bundle install

Then install the application:

```bash
bundle install # install dependencies
bundle exec rake db:setup # setup the database
bundle exec rails server # start the server
# visit http://localhost:3000
```

Docker
------
Docker image: https://registry.hub.docker.com/u/jonathanporta/verb-api/
