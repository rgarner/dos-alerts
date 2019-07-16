require 'spec_helper'
require 'dos/spider'

describe DOS::Spider, vcr: { cassette_name: 'fixed-list-of-opps' } do
  subject(:spider) { DOS::Spider.new }

  describe '#each_opportunity' do
    let(:opportunities) { [] }

    before do
      spider.each_opportunity do |opportunity|
        opportunities << opportunity
      end
    end

    it 'yields each open opportunity' do
      expect(opportunities.count).to eql(35)
    end
  end
end