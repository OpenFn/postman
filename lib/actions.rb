require 'inboxes'

module Action
end

class Action::Definition < Sequel::Model(:action_definitions)
  many_to_one :inbox, class: "Inbox"
end
