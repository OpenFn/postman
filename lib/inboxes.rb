class Inbox < Sequel::Model(:inboxes)
  one_to_many :job_roles, class: "Job::Role"
  one_to_many :event_definitions, class: "Event::Definition"
end
