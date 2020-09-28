require 'spec_helper'
require 'mechanize'

describe DOS::Opportunity, vcr: { cassette_name: 'fixed-list-of-opps', record: :new_episodes } do
  let(:response) { Mechanize.new.get(url) }

  subject(:opportunity) do
    DOS::Opportunity.new(response, url)
  end

  context 'the opportunity is an outcome' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/13199'
    end

    specify { expect(opportunity.type).to eql('Digital outcomes') }
    specify { expect(opportunity.id).to eql(13199) }
    specify { expect(opportunity.title).to eql('Accessibility Audit:  U16 Cancer Patient Experience survey website') }
    specify { expect(opportunity.published).to eql(Date.new(2020, 9, 28)) }
    specify { expect(opportunity.url).to eql(url) }
    specify { expect(opportunity.buyer).to eql('NHS England, Insight and Feedback Team') }
    specify { expect(opportunity.location).to eql('No specific location, for example they can work remotely') }
    specify { expect(opportunity.question_deadline).to eql(Date.new(2020, 10, 5)) }
    specify { expect(opportunity.closing).to eql(Date.new(2020, 10, 12)) }
    specify { expect(opportunity.expected_start_date).to eql(Date.new(2020, 10, 26)) }
    specify { expect(opportunity.description).to match(/The accessibility audit is to follow the WCAG-EM process/) }
  end

  context 'the opportunity is a specialist' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/13173'
    end

    specify { expect(opportunity.type).to eql('Digital specialists') }
    it 'has a role' do
      expect(opportunity.role).to eql('Technical Architect')
    end
  end

  context 'the opportunity is for User Research Participants' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/13188'
    end

    specify { expect(opportunity.type).to eql('User research participants') }
    specify { expect(opportunity.title).to eql('3-2-1 Customer journey UX testing, ref. 20-124C') }
  end
end
