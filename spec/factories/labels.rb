FactoryBot.define do
  factory :label do
    word { "test1" }
  end
  factory :second_label , class: Label do
    word { "test2" }
  end
  factory :third_label , class: Label do
    word { "test3" }
  end

  factory :many_label, class: Label do
    sequence(:word) { |n| "test#{n}" }
  end
end
