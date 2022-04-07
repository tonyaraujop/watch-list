every 5.minute do
  runner 'AssetsQuotesService.new.update_assets_quotes'
end
