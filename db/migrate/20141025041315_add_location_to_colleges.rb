class AddLocationToColleges < ActiveRecord::Migration
  def change
    add_column :colleges, :location, :string
  end
end
