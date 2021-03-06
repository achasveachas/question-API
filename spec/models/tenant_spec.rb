require 'rails_helper'

RSpec.describe Tenant, type: :model do
    before(:each) do
        @tenant = create(:tenant)
    end

    it "has a name" do
        expect(@tenant.name).not_to be_nil
    end

    it "gets created with an API key" do
        expect(@tenant.api_key).not_to be_nil
    end

    it "has a counter that defaults to 0" do
        expect(@tenant.counter).to eq(0)
    end
end