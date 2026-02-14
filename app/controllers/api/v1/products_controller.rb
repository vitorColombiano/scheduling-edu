class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :update, :destroy ]

  def index
    limit = (params[:per_page] || 10).to_i.clamp(1, 100)
    page = [ params[:page].to_i, 1  ].max
    offset = (page - 1) * limit

    @products = Product.limit(limit).offset(offset).order(:name)

    render json: {
      meta: {
        page: page,
        per_page: limit,
        total: Product.count
      },
      data: @products
    }
  end

  def show
    render json: @product
  end

  def create
    @product = Product.create!(product_params)
    render json: @product, status: :created
  end

  def update
    @product.update!(product_params)
    render json: @product
  end

  def destroy
    @product.destroy!
    head :no_content
  end

  private

  def set_product
    @product = Product.find_by!(uuid: params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :duration_minutes, :price, :status)
  end
end
