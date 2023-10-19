class ChangeTablePosts < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :published, :boolean
    change_column :posts, :body, :text
  end
end
