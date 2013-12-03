class Project < ActiveRecord::Base

  has_many :contributions
  has_many :users, :through => :contributions


  def time_left

    time = self.deadline - DateTime.now

    minutes = (time/60%60).ceil
    days = (time /60/60/24).floor
    hours = (time/60/60%24).floor

    return "#{days} days, #{hours} hours, #{minutes} minutes"
  end

end
