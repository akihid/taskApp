# 100.times do |n|
#   title = "test#{n}"
#   content = "test"
  
#   Task.create!(title: title,
#                content: content,
#                )
# end

1.times do |n|
  name = "user#{n}"
  mail = "user#{n}@co.jp"
  
  User.create!(name: name,
               mail: mail,
               )
end