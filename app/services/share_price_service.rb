class SharePriceService
  FLOAT_TO_INT_CONVERSION = 100

  def initialize(asset)
    @asset = asset
  end
  
  def get_share_price
    uri = URI.parse("https://statusinvest.com.br/acoes/#{@asset.downcase}")
    html = Nokogiri::HTML(Net::HTTP.get_response(uri).body)
    price = html.css("strong").first.text.gsub(",", ".").to_f*FLOAT_TO_INT_CONVERSION
  end
end
