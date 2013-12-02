class Project < ActiveRecord::Base

  has_many :contributions
  has_many :users, :through => :contributions
  
end
