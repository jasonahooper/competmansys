class Competition < ActiveRecord::Base

  scope :on_or_after, lambda { |start_date|
    Competition.where('start_date >= ?', start_date).order(:start_date)
  }
  scope :upcoming, lambda {
    Competition.on_or_after(Date.today + 1.day)
  }
  scope :between, lambda { |start_date, end_date|
    Competition.where('start_date between ? and ?', start_date, end_date).
      order(:start_date)
  }
  scope :miles_from, lambda { |lat, lng, miles|
    Competition.where('(point(?, ?) <@> point(longitude, latitude)) < ?',
      lng, lat, miles).order(:start_date)
  }
  scope :keywords, lambda { |keywords|
    keywords = '%' + keywords + '%'
    Competition.where('name like ? or description like ?', keywords, keywords)
  }

# WHERE (point(-97.515678, 35.512363) <@> point(longitude, latitude)) < 10

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

  geocoded_by :location
  after_validation :geocode
end


