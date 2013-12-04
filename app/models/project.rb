class Project < ActiveRecord::Base

  has_many :contributions
  has_many :users, :through => :contributions


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


  def funded
    counter = 0
    message = ""
    self.contributions.each do |c|
      counter += c.amount.to_i

    end

    left = self.goal - counter
    percent = ((counter/self.goal.to_f)* 100).ceil

    if percent >= 100
      "Project has been fully funded! $#{counter} of $#{self.goal} (#{percent}%) has been raised. "
    else
      "$#{counter} of $#{self.goal} (#{percent}%) has been raised, leaving $#{left} to go."
    end
  end

  def validate_owner(current_user)

    if self.user_id == current_user.id
      true
    else
      false
    end
  end
      
   

end
