class QuoteService
  def initialize(asset_symbol)
    @asset_symbol= asset_symbol
  end

  def quote_update
    price = SharePriceService.new(@asset_symbol).get_share_price
    asset = Asset.find_by!(symbol: @asset_symbol)
    asset.quotes.update_all(current: false)
    asset.quotes.create!(price: price, current: true, asset_id: asset.id)
  end
end
