class ImportPipedriveDeal
  attr_reader :token, :deal_ids, :deals_array
  def initialize(token, pipedrive_deal_ids, user_id)
    @deal_ids = pipedrive_deal_ids
    @token = token
    @user_id = user_id
  end

  def call
    fetch_deals
    @deals_array = deals_array.map do |deal_h|
      { 
        title: deal_h['title'],
        status: get_status(deal_h['status']),
        value: deal_h['value'],
        customer: deal_h['org_name'],
        expected_closing_date: deal_h['expected_close_date'],
        created_by_id: @user_id
      }
    end
    begin
      deals = Deal.create!(deals_array)
      SuccessResponse.new(deals)
    rescue ActiveRecord::RecordInvalid => e
      ErrorResponse.new([e.message], 'RECORD_INVALID', e.record)
    end
  end

  def fetch_deals
    @deals_array = deal_ids.map do |deal_id|
      resp = PipedriveCustom.new(token).deal_by_id(deal_id)
      resp.success? ? resp.data : nil
    end
    @deals_array.compact!
  end

  def get_status(status)
    if status == 'won' || status == 'lost'
      status
    else
      'pending'
    end
  end
end