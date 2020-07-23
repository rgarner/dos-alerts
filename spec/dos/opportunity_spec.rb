require 'spec_helper'
require 'mechanize'

describe DOS::Opportunity, vcr: { cassette_name: 'fixed-list-of-opps', record: :new_episodes } do
  let(:response) { Mechanize.new.get(url) }

  subject(:opportunity) do
    DOS::Opportunity.new(response, url)
  end

  context 'the opportunity is an outcome' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/12757'
    end

    specify { expect(opportunity.type).to eql('Digital outcomes') }
    specify { expect(opportunity.id).to eql(12757) }
    specify { expect(opportunity.title).to eql('FCO Consular Intelligent Client Function - Technical Architecture & Business Analysis') }
    specify { expect(opportunity.published).to eql(Date.new(2020, 7, 23)) }
    specify { expect(opportunity.url).to eql(url) }
    specify { expect(opportunity.buyer).to eql('Foreign and Commonwealth Office (FCO)') }
    specify { expect(opportunity.location).to eql('London') }
    specify { expect(opportunity.question_deadline).to eql(Date.new(2020, 7, 30)) }
    specify { expect(opportunity.closing).to eql(Date.new(2020, 8, 6)) }
    specify { expect(opportunity.expected_start_date).to eql(Date.new(2020, 9, 14)) }
    specify { expect(opportunity.description).to match(/Set up and embed FCO Consular's Architecture Function/) }
  end

  context 'the opportunity is a specialist' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/12733'
    end

    specify { expect(opportunity.type).to eql('Digital specialists') }
    it 'has a role' do
      expect(opportunity.role).to eql('Delivery manager')
    end
  end

  context 'the opportunity is for User Research Participants' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/12705'
    end

    specify { expect(opportunity.type).to eql('User research participants') }
    specify { expect(opportunity.title).to eql('Energy Performance of Buildings Register - User Research Subjects') }
  end
end
