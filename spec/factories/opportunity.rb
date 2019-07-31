FactoryBot.define do
  factory :opportunity do
    type { 'Digital outcomes' }

    trait :infer_url_from_id do
      after :build do |opportunity|
        base = 'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities/'
        opportunity.original_url = File.join(base, opportunity.original_id.to_s)
      end
    end
  end
end
