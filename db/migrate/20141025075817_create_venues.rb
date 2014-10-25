class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.decimal :rating
      t.integer :college_id

      t.timestamps
    end
    add_index :venues, :college_id
  end
end
