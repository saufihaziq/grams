class AddWebsiteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :website, :string
    add_column :users, :bio, :string
    add_column :users, :gender, :integer
    add_column :users, :phone_num, :integer 
  end
end