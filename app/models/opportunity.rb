class Opportunity < ActiveRecord::Base
  def self.from_scraped(opportunity)
    ::Opportunity.new(
      original_id: opportunity.id.to_i,
      original_url: opportunity.url
    )
  end

  def published?
    published_at.present?
  end
end