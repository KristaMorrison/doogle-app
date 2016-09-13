class Dictionary < ActiveRecord::Base
  validates :word, uniqueness: true
end
