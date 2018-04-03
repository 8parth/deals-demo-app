class Pipeline < ApplicationRecord
  belongs_to :user
  has_many :deals, dependent: :destroy
  validates :name, uniqueness: { scope: [:user_id], case_sensitive: false }

  scope :by_user_id, ->(user_id) { where(user_id: user_id) }
end
