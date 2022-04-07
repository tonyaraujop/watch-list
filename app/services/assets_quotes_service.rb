class AssetsQuotesService
  def update_assets_quotes
    Asset.all.each do |asset|
      SharePriceJob.perform_async(asset.symbol)
    end
  end
end
