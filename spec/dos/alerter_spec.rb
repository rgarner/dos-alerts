require 'spec_helper'

describe DOS::Alerter do
  let(:publisher)   { spy('DOS::Publisher') }
  let(:spider)      { double('DOS::Spider') }
  subject(:alerter) { DOS::Alerter.new(publisher) }

  before do
    allow(alerter).to receive(:spider).and_return(spider)
  end

  context 'no opportunities are new' do
    before do
      allow(spider).to receive(:each_opportunity) # yielding nothing
      alerter.run
    end

    it 'does not publish anything' do
      expect(publisher).not_to have_received(:publish)
    end
  end

  context 'some opportunities are new' do
    let(:published_id) { 10025 }
    let(:new_id)       { 10026 }

    let!(:existing_opportunity) do
      ::Opportunity.create(
        original_id: published_id,
        original_url: 'http://example.com/10025',
        published_at: Time.now
      )
    end

    let(:seen_opportunity) { double('DOS::Opportunity seen', id: published_id, url: '') }
    let(:new_opportunity)  { double('DOS::Opportunity new', id: new_id, url: '') }

    before do
      allow(spider).to receive(:each_opportunity)
        .and_yield(spider, seen_opportunity)
        .and_yield(spider, new_opportunity)
      alerter.run
    end

    it 'publishes only the new opportunity to the given publisher' do
      expect(publisher).to have_received(:publish).with(
        an_object_having_attributes(original_id: new_id)
      )
      expect(publisher).not_to have_received(:publish).with(
        an_object_having_attributes(original_id: published_id)
      )
    end
  end
end