FactoryBot.define do
  factory :song do
    title { "Test Song" }
    duration { 200 }
    mp3_url { "http://example.com/song.mp3" }
    association :artist
    association :album
    association :genre
  end
end