require 'rails_helper'

RSpec.describe UrlsController do
  let(:url) { create(:url) }

  describe 'POST #create' do
    let(:context) { Interactor::Context.new(response: { short_version: :test }) }
    let(:params) { { url: { full_version: :test } } }

    before { allow(Urls::Create).to receive(:call).and_return(context) }

    it do
      expect(Urls::Create).to receive(:call).with(params: { 'full_version' => 'test' })

      post :create, params: params

      expect(JSON.parse(response.body)).to include_json(short_version: 'test')
    end
  end

  describe 'GET #show' do
    it 'increment the counter' do
      get :show, params: { id: url.short_version }

      expect(url.reload.request_counter).to eq(1)
    end

    it 'redirect to the full_version' do
      get :show, params: { id: url.short_version }

      expect(response).to redirect_to(url.full_version)
    end
  end

  describe 'GET #show_stats' do
    it do
      get :show_stats, params: { id: url.short_version }

      expect(JSON.parse(response.body)).to include_json(request_counter: url.request_counter)
    end
  end
end
