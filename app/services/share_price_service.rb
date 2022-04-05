class SharePriceService
  FLOAT_TO_INT_CONVERSION = 100
  BASE_URL = "https://statusinvest.com.br/acoes/"
  
  def initialize(asset)
    @asset = asset
  end
  
  def get_share_price
    begin
      uri = URI.parse("#{BASE_URL}#{@asset.downcase}")
      html = Nokogiri::HTML(Net::HTTP.get_response(uri).body)
      price = html.css("strong").first.text.gsub(",", ".").to_f*FLOAT_TO_INT_CONVERSION
    rescue StandardError
      "URL can't be found"
    end
  end
end
