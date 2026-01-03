class Sauna < ApplicationRecord
  belongs_to :sauna_type, optional: true
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user
  has_many :sauna_opening_hours, dependent: :destroy
  accepts_nested_attributes_for :sauna_opening_hours, allow_destroy: true

  # ActiveAdmin / Ransack 用ホワイトリスト設定
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      address
      latitude
      longitude
      temperature
      water_temp
      has_outdoor_bath
      description
      sauna_type_id
      website_url
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[sauna_type reviews favorites favorited_by_users sauna_opening_hours]
  end
end
