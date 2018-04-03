class DealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deal, only: [:show, :edit, :update, :destroy]
  before_action :fetch_deals, only: [:index, :create, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_handler

  def index
    build_deal
  end

  def show
  end

  def new
    build_deal
  end

  def edit
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      build_deal
      flash.now[:notice] = 'Deal was successfully created.'
      respond_to do |format|
        format.html { redirect_to @deal }
        format.js
      end
    else
      build_deal
      flash.now[:error] = 'Deal could not be created.'
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    if @deal.update(deal_params)
      build_deal
      flash.now[:notice] = 'Deal Updated successfully.'
      respond_to do |format|
        format.html { redirect_to @deal }
        format.js
      end
    else
      build_deal
      flash.now[:error] = 'Deal could not be updated.'
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @deal.destroy
    build_deal
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.js
    end
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:id, :title, :customer, :status, :value, :expected_closing_date, :created_by_id)
  end

  def fetch_deals
    @q = Deal.by_user_id(current_user.id).ransack(params[:q])
    @deals = @q.result(distinct: true).page(params[:page])
  end

  def build_deal
    @deal = Deal.new(created_by_id: current_user.id, user_id: current_user.id)
  end

  def record_not_found_handler
    respond_to do |format|
      format.html { render :index }
    end
  end
end
