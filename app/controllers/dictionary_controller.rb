 require 'open-uri'
class DictionaryController < ApplicationController
  def index
    @definitions = []
  end
  
  def search
    @searchword = params[:word]
    
    if Dictionary.find_by(word: @searchword).nil?
      @doc = Nokogiri::XML(open('http://www.dictionaryapi.com/api/v1/references/collegiate/xml/' + @searchword + '?key=dea2bd9d-dce5-4716-86b5-8e4eac96d011')) 
      @ajaxresponse = @doc.css('dt')
      @definitions=[]
      
      if @ajaxresponse.empty?
        flash.now[:notice] = @searchword + " not found in dictionary."
      else
        @ajaxresponse.each do |definition|
          @definitions << definition.text.gsub(":", "")
        end
        Dictionary.create(word: @searchword, response: @definitions)
      end
      
    else
      @definitions = Dictionary.find_by(word: @searchword).response
    end

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
