Sequel.migration do
  transaction

  up {

    create_table :event_store_events  do
      primary_key :id
      uuid        :stream,      null: false
      varchar     :event_type,  null: false
      uuid        :event_id,    null: false
      jsonb       :metadata
      jsonb       :data,        null: false
      timestamp   :created_at,  null: false

      index :stream
      index :event_id, unique: true

    end

  }

  down {
    drop_table :event_store_events
  }
  
end

