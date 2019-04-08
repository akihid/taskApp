100.times do |n|
  title = "test#{n}"
  content = "test"
  
  Task.create!(title: title,
               content: content,
               )
end