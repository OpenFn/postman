require 'consequential'
require 'domain/receipt'


class CreateSubmission
  include Virtus.model

end

class SubmissionWorkflow < Consequential::Workflow

  on ReceiptReceived do |event|
    execute_command CreateSubmission.new({
      receipt_id: event.receipt_id
    })
  end
  
end
