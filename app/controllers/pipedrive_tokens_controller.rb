class PipedriveTokensController < ApplicationController
  before_action :authenticate_user!

  # Connects to pipedrive and stores the token in session.
  def create
    connection_information = PipedriveCustom.new(token_params[:token]).connection_information

    if connection_information.present?
      session[:pipedrive_token] = token_params[:token]
      @pipedrive_token = token_params[:token]
      list_pipelines_and_owners
      respond_to do |format|
        format.js { flash.now[:notice] = 'Connected to Pipedrive successfully!' }
      end
    else
      respond_to do |format|
        format.js { flash.now[:error] = 'Could not connect to Pipedrive.' }
      end
    end
  end

  # Removes the token from session.
  def destroy
    session[:pipedrive_token] = nil
    @pipedrive_token = nil
    flash.now[:success] = 'Disconnected'
    list_empty_pipelines_and_owners
    respond_to do |format|
      format.js
    end
  end

  private

  def token_params
    params.permit(:token)
  end

  def fetch_token
    @pipedrive_token = current_user.pipedrive_token || current_user.build_pipedrive_token
  end

  def list_pipelines_and_owners
    resp = PipedriveCustom.new(session[:pipedrive_token]).pipelines
    @pipelines = resp.success? ? resp.data : []
    resp = PipedriveCustom.new(session[:pipedrive_token]).owners
    @owners = resp.success? ? resp.data : []
  end

  def list_empty_pipelines_and_owners
    @pipelines = []
    @owners = []
  end
end
