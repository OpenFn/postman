Sequel.migration do
  transaction

  up {
    create_table(:event_definitions) {
      primary_key :id, type: 'uuid', null: false, 
        default: Sequel.lit("gen_random_uuid()")

      column :name, String, size: 100, null: false
      column :created_at, DateTime, default: Sequel.lit("now()")

      column :criteria, 'jsonb', null: false

      foreign_key :inbox_id, :inboxes, type: 'uuid', null: false
    }
  }

  down {
    drop_table :event_definitions
  }

end

