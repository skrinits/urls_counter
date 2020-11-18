require 'rails_helper'

RSpec.describe Url do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:short_version) }
    it { is_expected.to validate_presence_of(:full_version) }
    it { is_expected.to validate_uniqueness_of(:short_version) }
    it { is_expected.to validate_uniqueness_of(:full_version) }
  end
end
