# Custom Pipedrive API Wrapper
# Internally uses HTTParty to communicate with Pipedrive API (https://developers.pipedrive.com/docs/api/v1/).
# @param [String] token Valid token for authenticating requests.
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

  # Returns information of authenticated user. 
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

  # Returns information of pipelines for authenticated user.
  def pipelines
    api_path = '/pipelines'
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  # Returns information of owners for authenticated user.
  def owners
    api_path = '/users'
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  # Returns information of pipeline and owner for authenticated user.
  def deals_by_pipeline_and_owner(pipeline_id, owner_id)
    return SuccessResponse.new([]) if pipeline_id.blank? || owner_id.blank?
    api_path = "/pipelines/#{pipeline_id}/deals"
    @default_request_data[:user_id] = owner_id
    @resp = self.class.get(api_path, default_request_data)
    resp_parsing
  end

  # Returns detailed information of a deal by given Deal ID.
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
