class AddJustGivingIdToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :justgiving_id, :integer
  end
end
