Sequel.migration do
  transaction

  up {
    run 'CREATE EXTENSION pgcrypto;'
    run <<-EOL
      CREATE TABLE mappings(  
         "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
         "title" character varying(255) NOT NULL,
         "created_at" timestamp without time zone NOT NULL DEFAULT now(),
         "modified_at" timestamp without time zone NULL
      );
    EOL
  }

  down {
    run 'DROP EXTENSION pgcrypto;'
    drop_table :mappings
  }
  
end
