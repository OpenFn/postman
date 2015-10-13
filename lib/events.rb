require 'inboxes'
require 'jobs'

module Event
end

class Event::Definition < Sequel::Model(:event_definitions)
  many_to_one :inbox, class: "Inbox"
  one_to_many :job_roles, key: :trigger_id, class: "Job::Role"

  dataset_module do
    def by_matched_criteria(receipt)
      select_all(:event_definitions).
      join(:receipts, id: receipt.id).
      join(:inboxes, id: :inbox_id).
      where("receipts.body::jsonb @> event_definitions.criteria").
        where(event_definitions__inbox_id: receipt.inbox_id)

    end
  end
end
