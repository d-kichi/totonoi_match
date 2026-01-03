class SaunaOpeningHour < ApplicationRecord
  belongs_to :sauna
  validates :day_of_week, inclusion: { in: 0..6 }
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      sauna_id
      day_of_week
      opens_at
      closes_at
      closed
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[sauna]
  end
end
