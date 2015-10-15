Postman
=======

Message handler for OpenFn.

API
---

* `POST /inbox/:inboxID`
  
  Saves a receipt for a given mapping.

  Example Body:

  ```json
  { "Example": "json payload body" }
  ```

  ```xml
  <?xml version="1.0"?>
  <h:html xmlns="http://www.w3.org/2002/xforms">
    <input ref="some xml nonsense"/>
  </h:html>
  ```

  You may add a `Content-Type` mime header to override the default
  payload conversion handler.

  **Responses**

  - `404` Mapping not found.
  - `200` Success. Receipt was created.

* `GET /receipts/:receiptID`

  Returns information about a specified receipt.

  **Content-Type**

  - `text/plain`
  - `application/json` - *Not available yet*

CLI
---

Postman ships with a CLI client to perform common tasks and message
inspection tasks.

By default it looks for a Postman installation at: `http://postman.dev`

In order to change it prepend the command with: `HOST=http://myserver.com`

**Viewing a receipt**

  `postman receipt:show <UUID>`

  Shows the receipt information, including which submissions have processed
  it.

**Processing a receipt**

  `postman receipt:process <UUID>`

  Processes a receipt with any matching event definitions.


Setting up
----------

- Install Dependencies

  `$ bundle install`

- Set up the database

  ```sh
  $ createdb postman  
  $ DATABASE_URL=postgres://localhost/postman  
  $ sequel -m db/migrations $DATABASE_URL   
  ```

- Run the webserver

  `$ shotgun config.ru`

**ENV Variables**

`ENV`               *default: 'development'*  
`DATABASE_URL`      *default: 'postgres://localhost/postman'*  
`JOLT_SERVICE_URL`  *default: 'http://jolt-api.dev/'*

Running Tests
-------------

`$ rspec spec` or `$ bundle exec guard`

Running Migrations
------------------

`$ sequel -m db/migrations $DATABASE_URL` 

**Rolling back**

`$ sequel -m db/migrations -M x $DATABASE_URL`  
*`x` being the 'latest' migration number to keep*  

**Heroku**

Heroku provides a neat API for getting environment variables, in order to
run migrations you can replace `$DATABASE_URL` for single use cases like this:

```sh
( export `heroku config:get DATABASE_URL --shell` && \
  sequel -m db/migrations $DATABASE_URL )
```

By wrapping the commands in parentheses you can avoid changing you can avoid
polluting you local shell.
