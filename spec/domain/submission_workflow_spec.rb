require 'spec_helper'
require 'domain/submission_workflow'

describe SubmissionWorkflow do

  subject { publish double(ReceiptReceived, class: ReceiptReceived,receipt_id: 10) }

  it 'spec_name' do
    expect(CreateSubmission).to be_executed
    subject
  end

end
