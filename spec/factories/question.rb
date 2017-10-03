FactoryGirl.define do
  factory :question do
    asker User.create(name: FFaker::Name.name)
    title FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?")
    
  end
end