require 'spec_helper'
require 'mechanize'

describe DOS::Opportunity, vcr: { cassette_name: 'fixed-list-of-opps' } do
  let(:response) { Mechanize.new.get(url) }

  subject(:opportunity) do
    DOS::Opportunity.new(response, url)
  end

  context 'the opportunity is an outcome' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/10025'
    end

    specify { expect(opportunity.type).to eql('Digital outcomes') }
    specify { expect(opportunity.id).to eql(10025) }
    specify { expect(opportunity.title).to eql('Design and build a website for a new local authority') }
    specify { expect(opportunity.published).to eql(Date.new(2019, 7, 3)) }
    specify { expect(opportunity.url).to eql(url) }
    specify { expect(opportunity.buyer).to match(/Buckinghamshire Council/) }
    specify { expect(opportunity.location).to eql('South East England') }
    specify { expect(opportunity.question_deadline).to eql(Date.new(2019, 7, 10)) }
    specify { expect(opportunity.closing).to eql(Date.new(2019, 7, 17)) }
    specify { expect(opportunity.expected_start_date).to eql(Date.new(2019, 9, 2)) }
    specify { expect(opportunity.description).to match(/the five councils in Buckinghamshire/) }
  end

  context 'the opportunity is a specialist' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/9969'
    end

    specify { expect(opportunity.type).to eql('Digital specialists') }
    it 'has a role' do
      expect(opportunity.role).to eql('Developer')
    end
  end

  context 'the opportunity is for User Research Participants' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/9935'
    end

    specify { expect(opportunity.type).to eql('User research participants') }
  end

  context 'the opportunity format changed; falls over dereferencing buyer attribute, title broke' do
    let(:url) do
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/11438'
    end

    specify { expect(opportunity.buyer).to eql('Department for Digital, Culture, Media & Sport') }
    specify { expect(opportunity.title).to eql('End user Compute engineer') }
  end
end
