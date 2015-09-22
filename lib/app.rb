require 'inbox'
require 'receipts'
require 'mappings'

class App < Roda

  route do |r|

    r.on "receipts" do 
      r.run Receipts
    end

    r.on "inbox" do 
      r.run Inbox
    end

    r.on "mappings" do 
      r.run Mappings
    end

  end

end
