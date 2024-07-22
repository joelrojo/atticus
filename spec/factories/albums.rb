FactoryBot.define do
  factory :album do
    title { "Test Album" }
    release_date { Date.today }
    association :artist
    association :genre
  end
end