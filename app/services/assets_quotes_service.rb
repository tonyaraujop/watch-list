class AssetsQuotesService
  def update_assets_quotes
    Asset.all.each do |asset|
      queue_type = asset.wallet_items.present? ? :critical : :default
      SharePriceJob.set(queue: queue_type).perform_async(asset.symbol)
    end
  end
end
