class Project < ActiveRecord::Base

  has_many :contributions
  has_many :users, :through => :contributions

  has_many :comments, :as => :commentable

  belongs_to :category

  validates :name, presence: true
  validates :goal, presence: true
  validates :deadline, presence: true 


  # replace with distance_of_time_in_words
  def time_left
    time = self.deadline - DateTime.now

    if time >  0
      minutes = (time/60%60).ceil
      days = (time /60/60/24).floor
      hours = (time/60/60%24).floor

      return "Time left: #{days} days, #{hours} hours, #{minutes} minutes"
    else
      return "This project is now closed."
    end
  end

  def started
    (self.start_time - DateTime.now) < 0
  end

  def total_contributions
    self.contributions.sum(:amount)
  end

  def fully_funded
    self.contributions.sum(:amount) >= self.goal
  end


  def funded
    counter = self.contributions.sum(:amount)
    percent = ((counter/self.goal.to_f)* 100).ceil
    percent >= 100 ? 100 : percent
  end

  def validate_owner(current_user)
    self.user_id == current_user.id
  end
end
