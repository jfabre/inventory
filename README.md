# README


This projects is a website that feeds off the shoe-store socket server
It displays a heath map using d3.js and some metrics off the data it receives.
The heathmap will update live with new data coming in.

It uses foreman to load the websocket client, puma and and the webpacker services.
The configuration is in Procfile.dev

`bundle exec foreman start -f Procfile.dev`

It is currently configured to use:

- Postgresql as a database
- Redis as the message queue for ActionCable


For a good experience, wait until there's enough data fed to the database before loading the webpage.
