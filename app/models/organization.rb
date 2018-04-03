class Organization < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }

  has_many :deals, dependent: :destroy
end
