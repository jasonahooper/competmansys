class AddResultToEventRegistration < ActiveRecord::Migration
  def change
    add_column :event_registrations, :result, :string
    add_column :event_registrations, :position, :integer
  end
end
