# Wraps data with `success?` method which returns true.
# Data is wrapped inside SuccessResponse when request / operation performed was successful.
class SuccessResponse
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def success?
    true
  end
end
