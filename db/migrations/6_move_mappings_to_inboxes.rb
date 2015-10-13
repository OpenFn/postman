Sequel.migration do
  transaction

  up {
    run <<-EOL
      CREATE TABLE inboxes AS SELECT id FROM mappings;
      ALTER TABLE "public"."inboxes" 
        ALTER COLUMN "id" SET DEFAULT gen_random_uuid();
    EOL

    alter_table(:inboxes) {
      add_primary_key [:id]
    }

    alter_table(:receipts) {
      drop_constraint :receipts_mapping_id_fkey 
      rename_column :mapping_id, :inbox_id
      add_foreign_key [ :inbox_id ], :inboxes, name: :inbox_fk
    }
  }

end

