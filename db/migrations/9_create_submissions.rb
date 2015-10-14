DB.extension :pg_array, :pg_json
Sequel.migration do
  transaction

  up {
    create_table(:submissions) {
      primary_key :id, type: 'uuid', null: false,
        default: Sequel.lit("gen_random_uuid()")

      column :created_at, 'timestamp with time zone', default: Sequel.lit("now()")
      column :started_at, 'timestamp with time zone'
      column :finished_at, 'timestamp with time zone'

      column :success, 'boolean'
      column :log, 'jsonb', default: Sequel.pg_jsonb([])

      foreign_key :job_role_id, :job_roles, type: 'uuid'
      foreign_key :receipt_id, :receipts, type: 'uuid'
    }
  }

  down {
    drop_table :submissions
  }

end

