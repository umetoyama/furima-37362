FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { japanese_user.last.kanji }
    first_name            { japanese_user.first.kanji }
    last_name_read        { japanese_user.last.katakana }
    first_name_read       { japanese_user.first.katakana }
    birth_date            { Faker::Date.backward }
  end
end
