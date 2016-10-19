This exercise contains a [script for de-identifying](https://github.com/kenberland/exercise/blob/master/bin/cleanse.rb) a postgres database.  It uses Rails to generate some sample data, so that it has something to work on.  It uses [rvm](https://rvm.io/) to virtualize the ruby version and gemset, so it has a `.ruby-version` and `.ruby-gemset`.  You'll need to have postgres installed as well.

## Running it:

    bundle
    rake db:drop db:create db:setup
this makes the "exercise" database

    rake exercise:make_fake
this loads 10 users and 10 w9's

    NUM=100 rake exercise:make_fake
this would load 100

    createdb newdb
makes a db to receive the data, and

    pg_dump exercise | rails r ./bin/cleanse.rb | psql newdb
runs the script

