Sequel.migration do
  transaction

  up {
    create_table(:job_roles) {
      primary_key :id, type: 'uuid', null: false,
        default: Sequel.lit("gen_random_uuid()")

      column :name, String, size: 100, null: false
      column :created_at, DateTime, default: Sequel.lit("now()")

      column :jolt_spec, 'jsonb'
      column :configuration, 'jsonb'
      column :schema, 'jsonb'

      foreign_key :trigger_id, :event_definitions, type: 'uuid'
      foreign_key :inbox_id, :inboxes, type: 'uuid'
    }
  }

  down {
    drop_table :job_roles
  }

end

