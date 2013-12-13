class Competition < ActiveRecord::Base

  scope :upcoming, lambda {
    Competition.where('start_date > ?', Date.today)
  }

  validates :name, :presence => :true
  validates :description, :presence => :true
  validates :start_date, :presence => :true
  validates :end_date, :presence => true
  validates :image, :presence => true
  validates :registration_close_date, :presence => true
  validates :location, :presence => true

  validate :start_date_after_today
  validate :end_date_after_start_date
  validate :close_date_before_start_date

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add :end_date, "must be after start date"
    end
  end

  def start_date_after_today
    if start_date.present? && end_date.present? && start_date < Date.today
      errors.add :start_date, "must be after today"
    end
  end

  def close_date_before_start_date
    if registration_close_date.present? && start_date.present? &&
      registration_close_date > start_date
      errors.add :registration_close_date, "must be on or before start date"
    end
  end

  belongs_to :user

  has_many :competition_administrators
  has_many :events, :dependent => :destroy

  accepts_nested_attributes_for :events,
    reject_if: lambda {|attributes| attributes['name'].blank?}

  mount_uploader :image, CompetitionImageUploader

end
