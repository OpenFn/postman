Sequel.migration do
  transaction

  up {
    alter_table(:inboxes) {
      add_column :autoprocess, 'boolean', default: false
    }
  }

  down {
    alter_table(:inboxes) {
      drop_column :autoprocess
    }
  }

end

