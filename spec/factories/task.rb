FactoryBot.define do
  factory :task  do
    title { 'test_task_01' }
    content { 'testtesttest01' }
    deadline_at { Date.today }
    priority { 0 }
    status { 0 }
    user { User.first || create(:user)}
  end

  factory :second_task, class: Task do
    title { 'test_task_02' }
    content { 'testtesttest02' }
    deadline_at { Date.today + 1 }
    priority { 1 }
    status { 2 }
    user { User.first || create(:user)}
  end

  factory :third_task, class: Task do
    title { 'test_task_03' }
    content { 'testtesttest03' }
    deadline_at { Date.today + 2 }
    priority { 2 }
    status { 2 }
    user { User.first || create(:user)}
  end

  factory :length_test_task , class: Task do
    title { 'あ' *20}
    content { 'あ' *200}
    deadline_at { Date.today }
    priority { 0 }
    status { 0 }
    user { User.first || create(:user)}
  end

  factory :many_task, class: Task do
    sequence(:title) { |n| "title#{n}" }
    sequence(:content) { |n| "task#{n}" }
    deadline_at { Date.today + 2 }
    priority { 2 }
    status { 2 }
    user { User.first || create(:user)}
  end
end