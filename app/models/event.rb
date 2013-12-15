class Event < ActiveRecord::Base
  validates :name, :presence => :true
  validates :description, :presence => true

  belongs_to :competition
  has_many :event_registrations
end
