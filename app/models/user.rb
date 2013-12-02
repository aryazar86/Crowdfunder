class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :contributions

  #this is for users contributing to projects
  has_many :projects, :through => :contributions

  # this is for users creating projects
  has_many :projects

end
