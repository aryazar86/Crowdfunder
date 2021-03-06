class User < ActiveRecord::Base
  authenticates_with_sorcery!


   mount_uploader :avatar, AvatarUploader

  validates :password, confirmation: true
  validates :password_confirmation, presence: true


  validates_presence_of :password, :on => :create

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :contributions

  #this is for users contributing to projects
  has_many :projects, :through => :contributions

  # this is for users creating projects
  has_many :projects

  has_many :comments, :as => :commentable

  def amount_contributed
    # self.contributions.sum(:amount)
    total = 0

    self.contributions.each do |c|
      total += c.amount
    end

    return total
  end


  def validate_user(current_user)
    if current_user
      if self == current_user
        true
      end
    else
       false
    end
  end

end
