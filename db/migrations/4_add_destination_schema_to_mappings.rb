Sequel.migration do
  transaction

  up {
    run <<-EOL
      ALTER TABLE "mappings" ADD COLUMN "destination_schema" json;
    EOL
  }

  down {
    drop_column :mappings, :destination_schema
  }
  
end

