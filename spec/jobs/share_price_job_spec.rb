require 'rails_helper'

Sidekiq::Testing.fake!

RSpec.describe SharePriceJob, type: :job do
  let(:asset) { Asset.create!(symbol: 'PETR4', currency: 'BRL') }

  describe '#perform_async' do
    context 'valid attributes' do
      it 'enqueue jobs' do
        SharePriceJob.perform_async(asset.symbol)
        expect(SharePriceJob). to have_enqueued_sidekiq_job(asset.symbol)
      end

      it 'be retryable' do
        SharePriceJob.perform_async(asset.symbol)
        expect(SharePriceJob).to be_retryable 5
      end
    end
  end
end
