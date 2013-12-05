class Comment < ActiveRecord::Base
  validates :note, :presence => true

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
