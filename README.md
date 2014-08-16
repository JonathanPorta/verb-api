Verb API
======


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
# visit http://localhost:300
```
