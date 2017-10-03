json.question @question, :id, :title
json.asker @question.asker, :id, :name
json.answers @question.answers do |answer|
    json.id answer.id
    json.body answer.body
    json.answerer answer.answerer, :id, :name
end
