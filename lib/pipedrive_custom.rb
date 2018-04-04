class PipedriveCustom
  include HTTParty
  base_uri 'https://api.pipedrive.com/v1'

  attr_reader :token, :default_request_data, :resp

  def initialize(token)
    @token = token
    @default_request_data = {
      query: {
        api_token: token
      }
    }
  end

  def connection_information
    return nil if token.blank?
    api_path = '/users/me'
    @resp = self.class.get(api_path, default_request_data)
    if resp.parsed_response['success']
      resp['data']
    else
      nil
    end
  end

  def pipelines
    api_path = '/pipelines'
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  def owners
    api_path = '/users'
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  def deals_by_pipeline_and_owner(pipeline_id, owner_id)
    return SuccessResponse.new([]) if pipeline_id.blank? || owner_id.blank?
    api_path = "/pipelines/#{pipeline_id}/deals"
    @default_request_data[:user_id] = owner_id
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  def deal_by_id(deal_id)
    return ErrorResponse.new([], 'NOT_FOUND') if deal_id.blank?
    api_path = "/deals/#{deal_id}"
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  def resp_parsing
    if resp.parsed_response['success']
      SuccessResponse.new(resp['data'])
    else
      ErrorResponse.new([], resp['error_code'], resp)
    end
  end
end
