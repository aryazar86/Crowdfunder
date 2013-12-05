class AddCommentableToComment < ActiveRecord::Migration
  def change
    add_column :comments, :commentable_type, :string
    change_table :comments do |t|
      t.rename :project_id, :commentable_id
    end
  end
end
