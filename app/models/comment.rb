class Comment < ActiveRecord::Base
  validates :note, :presence => true

  belongs_to :user
  belongs_to :project
end
