##
# A persistable opportunity that knows when it's published
class Opportunity < ActiveRecord::Base
  def published?
    published_at.present?
  end

  def mark_published!
    update_attribute(:published_at, Time.now)
  end

  def self.from_scraped(opportunity)
    ::Opportunity.new(
      other_attrs(opportunity).merge(
        original_id: opportunity.id.to_i,
        original_url: opportunity.url
      )
    )
  end

  def self.other_attrs(opportunity)
    (DOS::Opportunity::ATTRIBUTES - %i[id url]).each_with_object({}) do |attr, hash|
      hash[attr] = opportunity.send(attr)
    end
  end
end