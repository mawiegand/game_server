=== Building the Rules

In order to generate the game rules from the XML definition and to adapt the database do the following steps:

1. In /rules call "make" in order to build the Ruby-Rules and place them in app.    
2. Call "./scripts/generate_rules_migration" in order to create a migration adapting the database to the present rules.
3. Execute "rake db:migrate" in order to apply the migrations

=== Updating the server

Before you update the server, you should build the rules locally (see above) and commit and push the changes to github. This will make sure the github repository has the latest rules and appropriate migrations with all necessary database fields. Then execute
  bundle exec cap deploy:migrations
to push the changes to the server.

