class CreateReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :image
      t.bigint :user_id
      t.bigint :shelter_id

      t.timestamps
    end
    add_foreign_key :reviews, :shelters
    add_foreign_key :reviews, :users
  end
end
