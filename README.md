Verb API
======

[![Build Status](https://travis-ci.org/JonathanPorta/verb-api.svg?branch=master)](https://travis-ci.org/JonathanPorta/verb-api)
[![Coverage Status](https://coveralls.io/repos/JonathanPorta/verb-api/badge.png)](https://coveralls.io/r/JonathanPorta/verb-api)

Server       | Watch/LiveReload/Tests/Lint
-------------|----------------------------
`$ rails s`  | `$ guard`

When using the `$ guard` file-watcher, installing [LiveReload Extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei) for Chrome will automatically refresh the browser on file-changes.

First-time install
------------------

Install system dependencies:
* Ruby/Bundler (probably via RVM)
* Postgres
* PhantomJS

Then install the application:

```bash
bundle install # install dependencies
bundle exec rake db:setup # setup the database
bundle exec rails server # start the server
# visit http://localhost:3000
```
