class Inquiry < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  # ActiveAdmin / Ransack 用: 検索を許可するカラムを明示
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email message created_at updated_at]
  end

  # 関連検索を許可する場合はここに書く（今回は関連なしなので空配列でOK）
  def self.ransackable_associations(auth_object = nil)
    []
  end
end