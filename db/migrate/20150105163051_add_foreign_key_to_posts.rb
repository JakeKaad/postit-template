class AddForeignKeyToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :foreign_id, :integer
  end
end
