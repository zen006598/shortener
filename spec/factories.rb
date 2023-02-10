FactoryBot.define do
  factory :url do
    original { "http://example.com/#{SecureRandom.uuid[0..5] }" }
  end
end