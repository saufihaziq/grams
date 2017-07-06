class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :fullname
      t.string :username
      t.string :password_digest

      t.timestamps
    end

      add_index :users, :email
      add_index :users, :username
      add_index :users, :fullname
  end
end