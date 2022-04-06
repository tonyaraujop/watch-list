require 'rails_helper'
RSpec.describe QuoteService, type: :service do
  let(:stock) { Asset.create!(symbol: 'PETR4', currency: 'BRL') }
  let!(:stock_price) {Quote.create!(price: 3000.0, current: true, asset_id: stock.id) }

  describe '#quote_update' do
    context 'when call' do
      it 'updates current quotes', :vcr do
        new_quote = VCR.use_cassette('petr4') { QuoteService.new(stock.symbol).quote_update }
        expect(stock_price.reload.current).to eq(false)
      end

      it 'creates a new quote', :vcr do
        new_quote = VCR.use_cassette('petr4') { QuoteService.new(stock.symbol).quote_update }
        expect(stock.last_quote).to eq(new_quote)
      end

      it 'creates new current quote', :vcr do
        new_quote = VCR.use_cassette('petr4') { QuoteService.new(stock.symbol).quote_update }
        expect(new_quote.current).to eq(true)
      end

      it 'creates new quote price', :vcr do
        new_quote = VCR.use_cassette('petr4') { QuoteService.new(stock.symbol).quote_update }
        expect(new_quote.price).to eq(3257.0)
      end
    end
  end
end
