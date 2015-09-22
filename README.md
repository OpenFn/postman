Postman
=======

Message handler for OpenFn.

API
---

* `POST /inbox/:mappingID`
  
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
  - `201` Success. Submission was created.

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

`ENV`          *default: 'development'*  
`DATABASE_URL` *default: 'postgres://localhost/postman'*

Running Tests
-------------

`$ rspec spec` or `$ bundle exec guard`

Running Migrations
------------------

`$ sequel -m db/migrations $DATABASE_URL` 

**Rolling back**

`$ sequel -m db/migrations -M x $DATABASE_URL`  
*`x` being the 'latest' migration number to keep*  

