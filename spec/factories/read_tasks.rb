FactoryBot.define do
  factory :read_task do
    task_id { 1 }
    user_id { 1 }
    read_flg { false }
  end
end
