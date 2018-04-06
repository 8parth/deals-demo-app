class Deal < ApplicationRecord
  # associations
  belongs_to :created_by, class_name: 'User'
  belongs_to :user, optional: true

  # attributes
  enum status: [:won, :lost, :pending]

  # validations
  validates :status, :value, :customer, :title, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }
  validates :weighted_value, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  accepts_nested_attributes_for :created_by, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  # scopes and class methods
  scope :by_user_id, ->(user_id) { where(created_by: user_id) }
end
