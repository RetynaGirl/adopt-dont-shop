class ChangeAdoptabilityToAdoptable < ActiveRecord::Migration[5.2]
  def change
    change_table :pets do |t|
      t.remove :adoptability
    end
  end
end
