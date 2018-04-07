require 'rails_helper'

RSpec.describe 'PipedriveTokens', type: :request do
  let(:pipedrive_token_params){
    {
      token: Rails.application.secrets.test_token
    }
  }
  describe 'POST /pipedrive_tokens' do
    context 'with authentication' do
      before { sign_in_as_a_valid_user }
      context 'with valid token' do
        before do
          post '/pipedrive_tokens', params: pipedrive_token_params, xhr: true
        end

        it 'assigns validated token to session' do
          expect(session[:pipedrive_token]).to eq(pipedrive_token_params[:token])
        end

        it 'assigns pipedrive_token' do
          expect(assigns(:pipedrive_token)).to eq(pipedrive_token_params[:token])
        end

        it 'renders pipedrive_tokens/_form partial' do
          expect(response).to render_template(partial: 'pipedrive_tokens/_form')
        end
      end

      context 'with invalid token' do
        before do
          post '/pipedrive_tokens', params: { token: 'invalidtoken' }, xhr: true
        end

        it 'does not assign token to session' do
          expect(session[:pipedrive_token]).to eq(nil)
        end

        it 'does not assign pipedrive_token' do
          expect(assigns(:pipedrive_token)).to eq(nil)
        end

        it 'renders pipedrive_tokens/_form partial' do
          expect(response).to render_template(partial: 'pipedrive_tokens/_form')
        end
      end
    end

    describe 'DELETE /pipedrive_tokens' do
      context 'with authentication' do
        before do
          sign_in_as_a_valid_user
          post '/pipedrive_tokens', params: pipedrive_token_params, xhr: true
          delete '/pipedrive_tokens', xhr: true
        end

        it 'clears token from session' do
          expect(session[:pipedrive_token]).to eq(nil)
        end

        it 'does not assign pipedrive_token' do
          expect(assigns(:pipedrive_token)).to eq(nil)
        end
      end
    end
  end
end
