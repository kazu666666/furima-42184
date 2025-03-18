FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { '渋谷区' }
    block { '渋谷1-2-3' }
    building { 'ヒカリエ10F' }
    phone_number { '09012345678' }
    token { "tok_abcdefghijk00000000000000000" }
  end
end