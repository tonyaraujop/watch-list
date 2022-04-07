class SharePriceJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(share_symbol)
    QuoteService.new(share_symbol).quote_update
  end
end
