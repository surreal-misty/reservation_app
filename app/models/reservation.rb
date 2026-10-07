class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :person_num, presence: true

  validates :person_num, numericality: {
    only_integer: true,
    greater_than: 0
  }

  validate :start_date_must_be_after_today
  validate :end_date_must_be_after_start_date

  def start_date_must_be_after_today
    if start_date.present? && start_date < Date.current
      errors.add(:start_date, "は今日以降の日付を選択してください")
    end
  end

  def end_date_must_be_after_start_date
    if start_date.present? && end_date.present? && end_date <= start_date
      errors.add(:end_date, "はチェックイン日より後の日付を選択してください")
    end
  end

  def total_amount
    room.price * person_num * (end_date - start_date).to_i
  end
end
