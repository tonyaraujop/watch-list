class WalletItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    asset = Asset.find_by(symbol: params[:symbol].upcase)
    share_price = SharePriceService.new(asset.symbol).get_share_price
    Quote.create!(price: share_price, current: true, asset_id: asset.id)
    wallet_item = WalletItem.new(wallet: current_user.wallet, asset: asset)

    respond_to do |format|
      if wallet_item.save
        format.html { redirect_to root_path, notice: "Wallet item was successfully created." }
      else
        format.json { render json: wallet_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    wallet_item = WalletItem.find(params[:id])
    wallet_item.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Wallet item was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
