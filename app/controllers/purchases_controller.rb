class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_not_purchasable, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_not_purchasable
    redirect_to root_path if @item.user_id == current_user.id || @item.purchase.present?
  end

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token).merge(
      item_id: @item.id, user_id: current_user.id
    )
  end
end
