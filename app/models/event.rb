class Event < ActiveRecord::Base
  validates :name, :presence => :true
  validates :description, :presence => true

  belongs_to :competition

  has_many :event_registrations
  has_many :registrants, :through => :event_registrations, :source => :competition_attendee
  has_many :entrants, :through => :registrants, :source => :user

  accepts_nested_attributes_for :event_registrations

  mount_uploader :image, EventImageUploader
end