class CreateBuyings < ActiveRecord::Migration[5.0]
  def change
    create_table :buyings do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.string :address

      t.timestamps
    end
  end
end