FactoryBot.define do

  factory :task  do
    title { 'test_task_01' }
    content { 'testtesttest01' }
    deadline_at { '2019-04-01' }
    priority { '高' }
    status { '未着手' }
  end

  factory :second_task, class: Task do
    title { 'test_task_02' }
    content { 'testtesttest02' }
    deadline_at { '2019-04-02' }
    priority { '高' }
    status { '着手' }
  end

  factory :third_task, class: Task do
    title { 'test_task_03' }
    content { 'testtesttest03' }
    deadline_at { '2019-04-03' }
    priority { '高' }
    status { '未着手' }
  end
end