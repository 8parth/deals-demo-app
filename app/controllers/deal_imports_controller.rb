class DealImportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pipedrive_token = session[:pipedrive_token]
    set_pipelines_and_owners
  end

  def deals
    session[:pipeline] = JSON.parse(params[:pipeline]).except('selected')
    session[:owner] = JSON.parse(params[:owner]).except('selected')
    @pipedrive_token = session[:pipedrive_token]
    set_pipelines_and_owners

    resp = PipedriveCustom.new(session[:pipedrive_token]).deals_by_pipeline_and_owner(session[:pipeline]['id'], session[:owner]['id'])
    @pipedrive_deals = resp.success? ? resp.data : []
    respond_to do |format|
      format.js
    end
  end

  def create
    resp = ImportPipedriveDeal.new(session[:pipedrive_token], params[:pipedrive_deals], current_user.id).call
    if resp.success?
      flash.now[:notice] = 'Deals Imported Successfully.'
    else
      flash.now[:error] = 'Deals Imported Successfully.'
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def set_pipelines_and_owners
    resp = PipedriveCustom.new(@pipedrive_token).pipelines
    @pipelines = resp.success? ? resp.data : []
    resp = PipedriveCustom.new(@pipedrive_token).owners
    @owners = resp.success? ? resp.data : []
  end
end
