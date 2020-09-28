require 'spec_helper'

describe DOS::Spider, vcr: { cassette_name: 'fixed-list-of-opps', record: :new_episodes } do
  subject(:spider) { DOS::Spider.new }

  describe '#each_opportunity' do
    context 'no block is given' do
      it 'throws a LocalJumpError' do
        expect { spider.each_opportunity }.to raise_error(LocalJumpError)
      end
    end

    context 'a block is given' do
      let(:opportunities) { [] }

      context 'and no opportunities have already been seen' do
        before do
          spider.each_opportunity do |_spider, opportunity|
            opportunities << opportunity
          end
        end

        it 'yields each open opportunity' do
          expect(opportunities.count).to eql(28)
        end
      end

      context 'and some opportunities have already been seen' do
        let!(:seen1) { create :opportunity, :infer_url_from_id, original_id: 13192 }
        let!(:seen2) { create :opportunity, :infer_url_from_id, original_id: 13173 }

        let(:dos_ids) { opportunities.map(&:id) }

        before do
          spider.each_opportunity do |_spider, opportunity|
            opportunities << opportunity
          end
        end

        it 'yields only the unseen open opportunities' do
          expect(dos_ids).not_to include(13192)
          expect(dos_ids).not_to include(13173)
          expect(opportunities.count).to eql(26)
        end
      end
    end
  end
end
