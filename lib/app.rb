require 'inbox'
require 'receipts'

class App < Roda

  route do |r|
    r.on "receipts" do 
      r.run Receipts
    end
    r.on "inbox" do 
      r.run Inbox
    end
  end

end
