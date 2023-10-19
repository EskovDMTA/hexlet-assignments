class RemoveColumsFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :text, :string
    remove_column :posts, :boolean, :string
  end
end
