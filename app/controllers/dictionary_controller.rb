class DictionaryController < ApplicationController
  def index
    @word = Word. new
  end
  
  def search
    render 'index'
  end
end
