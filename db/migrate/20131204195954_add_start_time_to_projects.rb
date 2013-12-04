class AddStartTimeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :start_time, :datetime
  end
end
