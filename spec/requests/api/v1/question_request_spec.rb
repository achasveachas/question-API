require 'rails_helper'

RSpec.describe "API::V1::Questions", type: :request do

    before(:each) do
        3.times {create(:answer)}
        @tenant = create(:tenant)
        @headers_with_key = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': "KEY: #{@tenant.api_key}"
            }
        @headers_without_key = {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
            }
    end

    describe "GET /questions" do

        it "returns an array of questions" do
            get "/api/v1/questions", headers: @headers_with_key
            body = JSON.parse(response.body)

            expect(response.status).to eq(200)
            expect(body['questions']).to be_an(Array)
            expect(body['questions'].size).to eq(3)
        end

    end

    describe "GET /question/:id" do

    end

end