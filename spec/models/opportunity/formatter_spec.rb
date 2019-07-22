require 'spec_helper'

describe Opportunity::Formatter do
  subject(:formatter) { Opportunity::Formatter.new(opportunity) }

  describe '#to_s' do
    let(:opportunity) do
      ::Opportunity.new(
        original_id: 10025,
        type: 'Digital specialists',
        original_url: 'https://example.com/opp/10025',
        title: 'Title',
        published: Date.new(2019, 7, 7),
        buyer: 'Buyer',
        location: 'Location',
        question_deadline: Date.new(2020, 7, 7),
        closing: Date.new(2021, 7, 7),
        expected_start_date: Date.new(2022, 7, 7),
        description: 'Description'
      )
    end

    subject(:formatted) { formatter.to_s }

    context 'Everything is there' do
      it 'has limited metadata and a summary truncated such that length is not exceeded' do
        expect(formatted).to eql <<~TEXT
          Specialists
          Buyer
          Title

          Location
          https://example.com/opp/10025
        TEXT
      end
    end
  end
end
