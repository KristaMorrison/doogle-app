 require 'open-uri'
class DictionaryController < ApplicationController
  def index
    @definitions = []
  end
  
  def search
    @searchword = params[:word]
    
    if Dictionary.find_by(word: @searchword).nil?
      @doc = Nokogiri::XML(open('http://www.dictionaryapi.com/api/v1/references/collegiate/xml/' + @searchword + '?key=dea2bd9d-dce5-4716-86b5-8e4eac96d011')) 
      @response = @doc.xpath("//dt").to_s

      if @response.empty?
        flash.now[:notice] = @searchword + " not found in dictionary."
      else
        Dictionary.create(word: @searchword, response: @response)
      end
    else
      @response = Dictionary.find_by(word: @searchword).response
    end
    
    @definitions = clean_up_response(@response.split("<dt>").reject(&:empty?))

    render 'index'
  end
  
  private
      
      def clean_up_response(response_array)
        response_array.each do |str|
          # remove colon from start
          str.tr!(":", "")
          # remove </dt> from end
          str.chomp!("</dt>")
          # make <vi> "e.g.", remove </vi> from end
          str.gsub!(/ <vi>/, ", e.g. ")
          str.chomp!("</vi>")
          #remove <it> and </it>
          str.gsub!(/<it>/, "")
          str.gsub!(/<\/it>/, "")
          
        end
      end
end
