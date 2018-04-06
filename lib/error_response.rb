# Wraps data with `success?` method which returns false.
# Data is wrapped inside SuccessResponse when request / operation performed was unsuccessful.
class ErrorResponse
  attr_reader :errors, :error_code, :record
  def initialize(errors, error_code = nil, record = nil)
    @errors = errors
    @error_code = error_code
    @record = record
  end

  def success?
    false
  end
end
