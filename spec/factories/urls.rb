FactoryBot.define do
  factory :url do
    short_version { SecureRandom.hex }
    full_version do
      "#{ FFaker::Internet.http_url }/#{ FFaker::Internet.slug }/"
    end
  end
end
