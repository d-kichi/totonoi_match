class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_saunas, through: :favorites, source: :sauna
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username,
            presence: true,
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  # ActiveAdmin / Ransack 4.x requires an explicit allowlist of searchable fields.
  # Keep this tight to avoid exposing sensitive fields (tokens, encrypted_password, etc.).
  def self.ransackable_attributes(auth_object = nil)
    attrs = %w[id email username created_at updated_at]
    attrs << "admin" if column_names.include?("admin")
    attrs
  end

  # Avoid auto-generating association filters that can trigger Ransack errors.
  # Add associations here only if you explicitly want them searchable.
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
