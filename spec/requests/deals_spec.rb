require 'rails_helper'

RSpec.describe 'Deals', type: :request do
  let(:deal_params) {
    {
      deal: FactoryBot.attributes_for(:deal)
    }
  }
  describe 'GET /deals' do
    context 'with authentication' do
      before(:all) do
        @user = FactoryBot.create(:user)
        @deals = FactoryBot.create_list(:deal, 20, created_by_id: @user.id, user_id: @user.id)
      end

      before do
        sign_in_as_a_valid_user
        get deals_path
      end

      it 'renders index' do
        expect(response).to render_template(:index)
      end

      it 'populates deals' do
        expect(assigns(:deals).ids).to match(Deal.by_user_id(@user.id).page(1).order(created_at: :desc).ids)
      end

      it 'renders new deal form' do
        expect(response).to render_template(partial: '_form')
      end

      it 'renders deals listing parial' do
        expect(response).to render_template(partial: '_deal_listing')
      end
    end

    context 'without authentication' do
      it 'denies access to deals#index' do
        get deals_path
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'GET /show/:id' do
    context 'with authentication' do
      before(:all) do
        @user = FactoryBot.create(:user)
        @deal = FactoryBot.create(:deal, created_by_id: @user.id, user_id: @user.id)
      end
      before(:each) do
        sign_in_as_a_valid_user
      end

      it 'renders show' do
        get deal_path(@deal)
      end
    end

    context 'without authentication' do
      before(:all) do
        @user = FactoryBot.create(:user)
        @deal = FactoryBot.create(:deal, created_by_id: @user.id, user_id: @user.id)
      end

      it 'denies access to deals#show' do
        get deal_path(@deal)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'GET /deals/new' do
    context 'with authentication' do
      before(:each) do
        sign_in_as_a_valid_user
        get new_deal_path
      end

      it 'renders new' do
        expect(response).to render_template(:new)
      end
    end

    context 'without authentication' do
      it 'denies access to deals#new' do
        get new_deal_path
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'GET /deals/:id' do
    context 'with authentication' do
      before(:each) do
        sign_in_as_a_valid_user
        @deal = FactoryBot.create(:deal, created_by_id: @user.id, user_id: @user.id)
        get edit_deal_path(@deal)
      end

      it 'renders edit' do
        expect(response).to render_template(:edit)
      end
    end

    context 'without authentication' do
      it 'denies access to deals#edit' do
        @user = FactoryBot.create(:user)
        @deal = FactoryBot.create(:deal, created_by_id: @user.id, user_id: @user.id)
        get edit_deal_path(@deal)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'POST /deals' do
    context 'with authentication' do
      before do
        sign_in_as_a_valid_user
      end

      context 'with valid params' do
        before do
          deal_params[:deal][:created_by_id] = @user.id
          deal_params[:deal][:user_id] = @user.id
          @count = Deal.count
          post deals_path, params: deal_params, xhr: true
        end
        it 'persists deal record' do
          expect(Deal.count).to eq(@count + 1)
        end

        it 'renders deal_listing partial' do
          expect(response).to render_template(partial: '_deal_listing')
        end

        it 'renders deal form partial' do
          expect(response).to render_template(partial: '_form')
        end
      end

      context 'with invalid params' do
        before do
          deal_params[:deal][:title] = nil
          deal_params[:deal][:created_by_id] = @user.id
          deal_params[:deal][:user_id] = @user.id
          @count = Deal.count
          post deals_path, params: deal_params, xhr: true
        end
        it 'does not persist deal record' do
          expect(Deal.count).to eq(@count)
        end

        it 'renders deal_listing partial' do
          expect(response).to render_template(partial: '_deal_listing')
        end

        it 'renders deal form partial' do
          expect(response).to render_template(partial: '_form')
        end
      end
    end
  end

  describe 'PATCH deals/:id' do
    context 'with authentication' do
      before do
        sign_in_as_a_valid_user
      end

      context 'with valid params' do
        before do
          @deal = FactoryBot.create(:deal)
          deal_params[:deal][:value] = 100
          patch deal_path(@deal), params: deal_params, xhr: true
        end
        it 'updates deal record' do
          expect(@deal.reload.value).to eq(100)
        end

        it 'renders deal_listing partial' do
          expect(response).to render_template(partial: '_deal_listing')
        end

        it 'renders deal form partial' do
          expect(response).to render_template(partial: '_form')
        end
      end

      context 'with invalid params' do
        before do
          @deal = FactoryBot.create(:deal)
          deal_params[:deal][:value] = 0
          patch deal_path(@deal), params: deal_params, xhr: true
        end

        it 'does not update deal record' do
          expect(@deal.reload.value).to eq(@deal.value)
        end
      end
    end
  end

  describe 'DELETE deals/:id' do
    context 'with authentication' do
      before { sign_in_as_a_valid_user }

      context 'with valid params' do
        before do
          @deal = FactoryBot.create(:deal)
          @count = Deal.count
          delete deal_path(@deal), xhr: true
        end

        it 'deletes deal record' do
          expect(Deal.count).to eq(@count - 1)
        end

        it 'renders deal_listing partial' do
          expect(response).to render_template(partial: '_deal_listing')
        end
      end
    end
  end
end
