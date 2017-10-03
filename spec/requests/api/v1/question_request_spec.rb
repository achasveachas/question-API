require 'rails_helper'

RSpec.describe "API::V1::Questions", type: :request do

    before(:each) do
        3.times {create(:answer)}
        @public_question = Question.first
        @private_question = create(:question, private: true)
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

        describe "on success" do

            before(:each) do
                get "/api/v1/questions", headers: @headers_with_key
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

        end
    end

    describe "GET /questions/:id" do

        describe "on success" do

            before(:each) do
                get "/api/v1/questions/#{@public_question.id}", headers: @headers_with_key
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
                get "/api/v1/questions/invalid_id", headers: @headers_with_key
                
                expect(response.status).to eq(404)
            end

            it "returns a status of 404 if question is private" do
                get "/api/v1/questions/#{@private_question.id}", headers: @headers_with_key
                
                expect(response.status).to eq(404)
            end
        end
    end

end