require 'spec_helper'
require 'dos/opportunity'
require 'mechanize'

describe DOS::Opportunity, vcr: { cassette_name: 'fixed-list-of-opps' } do
  let(:url)      { 'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/10025' }
  let(:response) { Mechanize.new.get(url) }

  subject(:opportunity) do
    DOS::Opportunity.new(response, url)
  end

  specify { expect(opportunity.id).to eql(10025) }
  specify { expect(opportunity.title).to eql('Design and build a website for a new local authority') }
  specify { expect(opportunity.published).to eql(Date.new(2019, 7, 3)) }
  specify { expect(opportunity.url).to eql(url) }
  specify { expect(opportunity.buyer).to eql('Buckinghamshire Council (contract with Buckinghamshire County Council)') }
  specify { expect(opportunity.location).to eql('South East England') }
  specify { expect(opportunity.question_deadline).to eql(Date.new(2019, 7, 10)) }
  specify { expect(opportunity.closing).to eql(Date.new(2019, 7, 17)) }
  specify { expect(opportunity.expected_start_date).to eql(Date.new(2019, 9, 2)) }
  specify { expect(opportunity.description).to match(/the five councils in Buckinghamshire/) }

end