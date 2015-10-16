class App < Roda

  plugin :render, views: 'lib/views'
  plugin :header_matchers
  plugin :all_verbs
  plugin :indifferent_params

  route do |r|

    r.on "receipts" do 

      r.on :id do |id|
        @receipt = Receipt::Record[id]

        r.on !!@receipt do

          r.post do
            # POST /receipts/:id/process
            r.is "process" do

              r.on accept: 'text/plain' do
                Receipt::Match.new.async.perform(@receipt)
                response[ 'Content-Type' ] = "text/plain"
                render(inline: 'Queued for Matching')
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
  end

  route do |r|

    r.on "inbox" do
      response[ 'Content-Type' ] = "application/json"

      r.on :inbox_id do |inbox_id|

        @inbox = Inbox.find(id: inbox_id)

        r.on !!@inbox do

          # POST /inbox/:inbox_id
          r.post do

            Log.debug "Receipt Arrived"

            receipt = @inbox.add_receipt(body: request.body.read)

            Log.debug "Receipt Stored"

            if @inbox.autoprocess
              Receipt::Match.new.async.perform(receipt)
              Log.info "Receipt (#{receipt.id}) queued for matching."
            end

            response.status = 200

            # TODO: return the receipt id
            # {
            #   "@id"=> (Pathname.new(request.base_url) + "receipts/#{receipt[:id]}")
            # }.to_json
          end

          # PATCH /inbox/:inbox_id?autoprocess=<true|false>false
          r.patch do

            @inbox.update_fields(params, ["autoprocess"], missing: :skip)
            r.on accept: 'text/plain' do
              response[ 'Content-Type' ] = "text/plain"
              render(inline: "Inbox updated")
            end
          end

        end

      end

    end

  end

end
