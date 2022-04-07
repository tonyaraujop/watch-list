require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe AssetsQuotesService, type: :service do
  Sidekiq::Testing.fake!
  
  let!(:user) { User.create!(email: 'test@test.com', password: '123456')}
  let(:wallet) { Wallet.create!(user: user) }
  let!(:petr4) { Asset.create!(symbol: 'PETR4', currency: 'BRL') }

  describe '#update_assets_quotes' do
    context "when have asset on wallet" do
      let!(:watch_list) { WalletItem.create!(wallet: wallet, asset: petr4) }
      
      it 'watch list asset has queue critical' do
        expect(SharePriceJob).to receive(:set).with({queue: :critical}).and_call_original
        AssetsQuotesService.new.update_assets_quotes
        expect(SharePriceJob).to have_enqueued_sidekiq_job(petr4.symbol)
      end
    end

    context "when don't have asset on wallet" do
      it 'watch list asset has queue default' do
        expect(SharePriceJob).to receive(:set).with({queue: :default}).and_call_original
        AssetsQuotesService.new.update_assets_quotes
        expect(SharePriceJob).to have_enqueued_sidekiq_job(petr4.symbol)
      end
    end
  end
end
