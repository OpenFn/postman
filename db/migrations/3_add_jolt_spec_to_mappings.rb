Sequel.migration do
  transaction

  up {
    run <<-EOL
      ALTER TABLE "mappings" ADD COLUMN "jolt_spec" json;
    EOL
  }

  down {
    drop_column :mappings, :jolt_spec
  }
  
end

