class AddAdoptabilityAndDescriptionToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :adoptability, :boolean
    add_column :pets, :description, :string
  end
end
