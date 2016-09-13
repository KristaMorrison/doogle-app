require 'rails_helper'

RSpec.describe DictionaryController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #search" do
    
    context "word isn't in database" do
      it "adds word to database" do
        expect(Dictionary.find_by(word: "osmosis")).to be nil
        get :search, { word: "osmosis"}
        expect(Dictionary.find_by(word: "osmosis")).to_not be nil
      end
      
      it "adds associated definitions to database" do
        expect(Dictionary.find_by(word: "osmosis")).to be nil
        get :search, { word: "osmosis"}
        expect(Dictionary.find_by(word: "osmosis").response).to_not be nil
      end
    end
    
    context "word is in database" do
      it "assigns definitions from database" do
        get :search, { word: "osmosis"}
        expect(assigns(:response)).to eq(Dictionary.find_by(word: "osmosis").response)
      end
    end
    
    
  end

end
