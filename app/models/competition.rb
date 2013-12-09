class Competition < ActiveRecord::Base
  validates :name, :presence => :true
  validates :description, :presence => :true
  validates :start_date, :presence => :true
  validates :end_date, :presence => true
  validates :image, :presence => true
  validate :start_date_after_today
  validate :end_date_after_start_date

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
end
