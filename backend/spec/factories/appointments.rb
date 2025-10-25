FactoryBot.define do
  factory :appointment do
    user { nil }
    appointment_date { "2025-10-25 19:33:06" }
    salon_name { "MyString" }
    salon_id { "MyString" }
    status { "MyString" }
    notes { "MyText" }
  end
end
