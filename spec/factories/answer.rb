FactoryGirl.define do
  factory :answer do
    user
    question
    body FFaker::HipsterIpsum.sentence
  end
end