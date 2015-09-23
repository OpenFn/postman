Sequel.migration do
  transaction

  up {
    run <<-EOL
      ALTER TABLE "mappings" ADD COLUMN "destination_configuration" json;
    EOL
  }

  down {
    drop_column :mappings, :destination_configuration
  }
  
end

