class User < ActiveRecord::Base
  ROLES = %w[admin competition_owner]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  has_many :competitions
  has_many :competition_administrators
  has_many :competition_attendees
  has_many :attending, :through => :competition_attendees, :source => :competition
  has_many :registrations, :through => :competition_attendees, :source => :event_registrations
  has_many :entered, :through => :registrations, :source => :event

  geocoded_by :home_address
  after_validation :geocode

  def full_name
    return self.first_name + ' ' + self.last_name
  end
end
