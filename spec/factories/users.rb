FactoryBot.define do
  factory :user do
    name { "test1" }
    mail { "test1@co.jp" }
    password { "111111" }
    password_confirmation { "111111" }
    role{true}
  end

  factory :second_user, class: User do
    name { "test2" }
    mail { "test2@co.jp" }
    password { "111111" }
    password_confirmation { "111111" }
    role{true}
  end
end
