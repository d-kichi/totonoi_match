class Sauna < ApplicationRecord
  belongs_to :sauna_type, optional: true

  # ActiveAdmin / Ransack 用ホワイトリスト設定
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      location
      latitude
      longitude
      temperature
      water_temp
      has_outdoor_bath
      open_time
      close_time
      description
      sauna_type_id
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["sauna_type"]
  end
end
