FactoryGirl.define do
  factory :answer do
    answerer User.create(name: FFaker::Name.name)
    question
    body FFaker::HipsterIpsum.sentence
  end
end