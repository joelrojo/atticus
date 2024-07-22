FactoryBot.define do
  factory :playlist do
    name { "Test Playlist" }
    description { "A test playlist" }
    association :user
  end
end