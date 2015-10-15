require 'inbox'
require 'receipts'

class App < Roda

  plugin :render, views: 'lib/views'
  plugin :header_matchers

  route do |r|

    r.on "receipts" do 
      
      r.on :id do |id|
        @receipt = Receipt::Record[id]

        r.on !!@receipt do

          r.post do
            r.is "process" do

              r.on accept: 'text/plain' do
                Receipt::Matcher.handle(@receipt)
                response[ 'Content-Type' ] = "text/plain"
                render(inline: 'OK')
              end

            end
          end

          r.get do
            r.on accept: 'text/plain' do
              response[ 'Content-Type' ] = "text/plain"
              render('receipts/show.txt', locals: {receipt: @receipt})
            end
          end
        end
      end
    end

    r.on "inbox" do 
      r.run InboxAPI
    end

  end

end
