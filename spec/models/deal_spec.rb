require 'rails_helper'

RSpec.describe Deal, type: :model do
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:customer) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:weighted_value).is_greater_than_or_equal_to(0) }

  it { is_expected.to define_enum_for(:status) }
  
  it { is_expected.to belong_to(:created_by) }
  it { is_expected.to belong_to(:user) }
end
