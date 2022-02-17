module Api
	module V1
		class ProductsController < ApplicationController
      before_action :find_product, only: [:update, :destroy, :show]

			def index
        @products = Product.all

        render json: @products
			end

			def create
				@product = Product.new(product_params)
				if @product.save
					render json: { message: 'Produto criado!', data: @product }, status: :ok
				else
					render json: { message: 'Erro ao criar o produto', data: @product.errors }, status: :unprocessable_entity
				end
			end

      def update
        @product.update_attributes(product_params)
        render json: { message: 'Produto atualizado', data: @product }, status: :ok
      end

      def show
				render json: { data: @product }, status: :ok
      end

      def destroy
    		@product.destroy
    		render json: { status: 'Produto excluído' }
    	end

      private

      def product
        @product ||= Product.find_by(id: params[:id])
      end

      def find_product
        product_not_found unless product
      end

      def product_not_found
        render json: { status: 'Produto não encontrado' }, status: :not_found
      end

      def product_params
        params.require(:product).permit(:sku, :name, :cost_price)
      end
		end
	end
end
