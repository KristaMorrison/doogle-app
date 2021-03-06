require 'rails_helper'

RSpec.describe "dictionary/index.html.erb", type: :view do
  before :each do 
    visit root_path
  end
  
  describe "search form" do
    it "has a word field" do
      expect(page).to have_field 'word'
    end
    
    it "allows a user to fill in word field" do
      fill_in 'word', with: "name"
      click_button "Doogle Search"
      expect(response).to render_template('index')
    end
    
    it "lists definitions when word is searched" do
      fill_in 'word', with: "name"
      click_button "Doogle Search"
      expect(page).to have_text('a word or phrase that constitutes the distinctive designation of a person or thing')
    end
  end
end
