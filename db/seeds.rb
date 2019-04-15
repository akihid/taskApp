# 100.times do |n|
#   title = "test#{n}"
#   content = "test"
  
#   Task.create!(title: title,
#                content: content,
#                )
# end

# 1.times do |n|
#   name = "user#{n}"
#   mail = "user#{n}@co.jp"
#   password = "111111"
  
#   User.create!(name: name,
#                mail: mail,
#                password: password,
#                password_confirmation: password,
#                )
# end


10.times do |n|
  word = "test#{n}"
  Label.create!(word: word,
               )
end