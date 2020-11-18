require 'rails_helper'

RSpec.describe Urls::Create do
  subject(:result) { described_class.call(params: params) }

  let(:params) { attributes_for(:url).slice(:full_version) }
  let(:short_version) { 'test' }

  before { allow(SecureRandom).to receive(:hex).and_return(short_version) }

  context 'if short_version generation is not over limit' do
    context 'and params is valid' do
      it do
        expect(result.response).to eq(short_version: short_version)
      end
    end

    context 'and params is invalid' do
      let(:params) { { full_version: '' } }

      it do
        expect(result.response[:errors].messages).to eq(
          { full_version: ["can't be blank"] }
        )
      end
    end
  end

  context 'if short_version generation is over limit' do
    let(:url) { build(:url, full_version: params[:full_version]) }
    let!(:url_with_the_same_short_version) { create(:url, short_version: short_version) }

    before do
      allow(Url).to receive(:new).and_return(url)
      allow(url).to receive(:save).exactly(
        described_class::NUMBER_CREATION_TRIES
      ).time.and_raise(ActiveRecord::RecordNotUnique)
    end

    it do
      expect { result }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
