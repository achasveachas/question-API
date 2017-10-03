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

        before(:each) do
            get "/api/v1/questions", headers: @headers_with_key
            @response = response
            @body = JSON.parse(@response.body)
        end

        it "returns an array of questions" do

            expect(@response.status).to eq(200)
            expect(@body['questions']).to be_an(Array)
            expect(@body['questions'].size).to eq(3)
        end

        it "questions include asker info" do
            expect(@body['questions'][0]['asker']).to include('id', 'name')
        end

        it "questions include answer info" do
            expect(@body['questions'][0]['answers'][0]).to include('id', 'body', 'answerer')
        end
    end

    describe "GET /question/:id" do

    end

end