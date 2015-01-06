class RemoveForeignKeyFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :foreign_key
  end
end
