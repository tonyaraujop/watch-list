require 'rails_helper'
RSpec.describe SharePriceService, type: :service do
  let(:stock) { "petr4" }
  let(:invalid_stock) { "test_error" }

  describe 'get stock price' do
    context 'in a web page' do
      it 'should return actual value', :vcr do
        value = VCR.use_cassette(stock) { SharePriceService.new(stock).get_share_price }
        expect(value).to eq(3257.0)
      end

      it 'should return actual value', :vcr do
        value = VCR.use_cassette(stock) { SharePriceService.new(invalid_stock).get_share_price }
        expect { value }.to rescue(StandardError)
      end
    end
  end
end
