FactoryBot.define do
  factory :user do
    nickname              {'TestUser'}
    email                 {Faker::Internet.unique.email}
    password              {'a00000'}
    password_confirmation {'a00000'}
    first_name            {'太郎'}
    last_name             {'田中'}
    first_name_kana       {'タロウ'}
    last_name_kana        {'タナカ'}
    birthday              {'2000-01-01'}
  end
end