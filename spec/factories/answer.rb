FactoryGirl.define do
  factory :answer do
    provider User.create(name: FFaker::Name.name)
    question
    body FFaker::HipsterIpsum.sentence
  end
end