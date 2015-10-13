require 'inboxes'
require 'events'

module Job
end

class Job::Role < Sequel::Model(:job_roles)
  many_to_one :inbox, class: "Inbox"
  many_to_one :trigger, class: "Event::Definition"
end
