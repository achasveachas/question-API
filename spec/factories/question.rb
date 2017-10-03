FactoryGirl.define do
  factory :question do
    user
    title FFaker::HipsterIpsum.sentence
    private FFaker::Boolean.random
  end
end