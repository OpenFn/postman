require 'inbox'
require 'receipts'
require 'submissions'

class App < Roda

  plugin :render, views: 'lib/views'
  plugin :header_matchers

  route do |r|

    r.on "receipts" do 
      
      r.on :id do |id|
        @receipt = Receipt::Record[id]

        r.on !!@receipt do

          r.post do
            # POST /receipts/:id/process
            r.is "process" do

              r.on accept: 'text/plain' do
                Receipt::Matcher.handle(@receipt)
                response[ 'Content-Type' ] = "text/plain"
                render(inline: 'OK')
              end

            end
          end

          r.get do
            # GET /receipts/:id
            r.on accept: 'text/plain' do
              response[ 'Content-Type' ] = "text/plain"
              render('receipts/show.txt', locals: { receipt: @receipt })
            end
          end
        end
      end
    end

    r.on "submissions" do
      r.on :uuid do |uuid|

        @submission = Submission::Attempt[uuid]

        r.on !!@submission do
          # GET /submissions/:uuid
          r.on accept: 'text/plain' do
            response[ 'Content-Type' ] = "text/plain"
            render('submissions/show.txt', locals: { submission: @submission })
          end

        end
      end
    end

    r.on "inbox" do 
      r.run InboxAPI
    end

  end

end
