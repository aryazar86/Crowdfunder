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


  def funded
    counter = 0
    self.contributions.each do |c|
      counter += c.amount.to_i

    end

    left = self.goal - counter
    percent = ((counter/self.goal.to_f)* 100).ceil

    "$#{counter} of $#{self.goal} (#{percent}%) has been raised, leaving $#{left} to go."
  end

end
