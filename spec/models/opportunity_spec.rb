require 'spec_helper'

describe ::Opportunity do
  describe '.from_scraped' do
    let(:fake_scraped) do
      double(
        'DOS::Opportunity',
        id: 10025,
        url: 'https://example.com/opp/10025',
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

    subject(:opportunity) { ::Opportunity.from_scraped(fake_scraped) }

    it 'maps important "original" properties' do
      expect(opportunity.original_id).to eql(10025)
      expect(opportunity.original_url).to eql('https://example.com/opp/10025')
    end

    it { is_expected.not_to be_published }

    context 'the published_at date is set' do
      before { opportunity.update_attribute(:published_at, Time.now) }
      it     { is_expected.to be_published }
    end
  end
end