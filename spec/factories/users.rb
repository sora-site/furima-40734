FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'test1234' }
    password_confirmation { password }
    kanji_name_sei { person.first.kanji }
    kanji_name_mei { person.last.kanji }
    kana_name_sei { person.first.katakana }
    kana_name_mei { person.last.katakana }
    birthday { Faker::Date.backward }
  end
end
