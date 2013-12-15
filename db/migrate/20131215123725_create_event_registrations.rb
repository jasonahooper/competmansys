class CreateEventRegistrations < ActiveRecord::Migration
  def change
    create_table :event_registrations do |t|
      t.integer :event_id
      t.integer :competition_attendee_id

      t.timestamps
    end
  end
end
