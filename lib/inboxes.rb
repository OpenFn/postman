class Inbox < Sequel::Model(:inboxes)
  one_to_many :job_roles, class: "Job::Role"
  one_to_many :event_definitions, class: "Event::Definition"
  one_to_many :action_definitions, class: "Action::Definition"
end
