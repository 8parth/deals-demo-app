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
