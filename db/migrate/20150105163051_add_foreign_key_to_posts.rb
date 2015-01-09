class AddForeignKeyToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :foreign_key, :integer
  end
end
