class Dictionary < ActiveRecord::Base
  validates :word, uniqueness: true
  serialize :response
end
