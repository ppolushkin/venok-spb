class Page < ActiveRecord::Base

  has_many :revisions

  validates :reference, :title, :presence => true
  validates :reference, :uniqueness => true
  
end
