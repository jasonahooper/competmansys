class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :competition_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
