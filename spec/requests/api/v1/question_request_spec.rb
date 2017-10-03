require 'rails_helper'

RSpec.describe "API::V1::Questions", type: :request do

    before(:each) do
        3.times {create(:answer)}
        @public_question = Question.first
        @private_question = create(:question, private: true)
        @tenant = create(:tenant)
        @counter = @tenant.counter
        @key = @tenant.api_key
            

    end

    describe "GET /questions" do

        describe "on success" do

            before(:each) do
                get "/api/v1/questions?authorization=#{@key}"
                @response = response
                @body = JSON.parse(@response.body)
            end

            it "returns an array of questions" do

                expect(@response.status).to eq(200)
                expect(@body['questions']).to be_an(Array)
                expect(@body['questions'][0]).to include('id', 'title')            
            end

            it "questions include asker info" do
                expect(@body['questions'][0]['asker']).to include('id', 'name')
            end

            it "questions include answer info" do
                expect(@body['questions'][0]['answers'][0]).to include('id', 'body', 'answerer')
            end

            it "doesn't return private questions" do
                expect(@body['questions'].last).not_to include('id' => @private_question.id)
            end

            it "increments the tenant's counter" do
                tenant = Tenant.find_by(id: @tenant.id)
                expect(tenant.counter).to eq(@counter + 1)
            end

        end

        describe "on failure" do
            it "returns a status of 401 if API key is not provided" do
                get "/api/v1/questions"
                @body = JSON.parse(response.body)
                
                expect(response.status).to eq(401)
                expect(@body['errors']).to include("Incorrect API Key")
            end
        end
    end

    describe "GET /questions/:id" do

        describe "on success" do

            before(:each) do
                get "/api/v1/questions/#{@public_question.id}?authorization=#{@key}"
                @response = response
                @body = JSON.parse(@response.body)
            end

            it "returns the requested question" do
                expect(@response.status).to eq(200)
                expect(@body['question']).to include('id', 'title')            
            end

            it "question include asker info" do
                expect(@body['asker']).to include('id', 'name')
            end

            it "question include answer info" do
                expect(@body['answers'][0]).to include('id', 'body', 'answerer')
            end
        end

        describe "on failure" do

            it "returns a status of 404 if question doesn't exist" do
                get "/api/v1/questions/invalid_id?authorization=#{@key}"
                
                expect(response.status).to eq(404)
            end

            it "returns a status of 404 if question is private" do
                get "/api/v1/questions/#{@private_question.id}?authorization=#{@key}"
                
                expect(response.status).to eq(404)
            end

            it "returns a status of 401 if API key is not provided" do
                get "/api/v1/questions/#{@public_question.id}"
                @body = JSON.parse(response.body)
                
                expect(response.status).to eq(401)
                expect(@body['errors']).to include("Incorrect API Key")
            end
        end
    end

end