require 'rails_helper'

RSpec.describe Dictionary, type: :model do
  
  before do
    @word = "test"
    @doc = Nokogiri::XML(open('http://www.dictionaryapi.com/api/v1/references/collegiate/xml/test?key=dea2bd9d-dce5-4716-86b5-8e4eac96d011')) do |config|
        config.noblanks.strict 
    end
    @response = @doc.xpath("//dt").to_s
    Dictionary.create(word: @word, response: @response)
  end
  
  it "adds an entry to the dictionary" do
    expect(Dictionary.count).to be(1)
  end
  
  it "saves the word as a string" do
    expect(Dictionary.first.word).to eq("test")
  end
  
  it "saves the definitions response as a string" do
    expect(Dictionary.first.response).to be_a(String)
  end
  
  it "does not save a word already in the dictionary" do
    expect(Dictionary.count).to be(1)
    Dictionary.create(word: "test", response: "test response")
    expect(Dictionary.count).to be(1)
  end
end
