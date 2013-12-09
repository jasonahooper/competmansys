class AddRegistrationCloseDateToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :registration_close_date, :date
  end
end
