require 'rails_helper'
RSpec.describe AssetsQuotesService, type: :service do
  describe '#update_assets_quotes' do
    it 'calls' do
      assets = AssetsQuotesService.new
      allow(AssetsQuotesService.new).to receive(:update_assets_quotes).and_return([])
      expect(assets.update_assets_quotes).to eq([])
    end
  end
end
