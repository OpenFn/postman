require 'inboxes'
require 'events'

module Job
end

class Job::Role < Sequel::Model(:job_roles)
  one_to_many :submissions, key: :job_role_id, class: "Submission::Attempt"
  many_to_one :inbox, class: "Inbox"
  many_to_one :trigger, class: "Event::Definition"
end
