Sequel.migration do
  transaction

  up {
    run <<-EOL
      CREATE TABLE receipts(  
         "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
         "mapping_id" UUID NOT NULL REFERENCES "mappings"("id") ON DELETE CASCADE,
         "body" text NOT NULL,
         "created_at" timestamp without time zone NOT NULL DEFAULT now()
      );
    EOL

    alter_table(:receipts) do
      add_index :mapping_id
    end
  }

  down {
    drop_table :receipts
  }
  
end
