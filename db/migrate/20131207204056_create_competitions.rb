class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :image

      t.timestamps
    end
  end
end
