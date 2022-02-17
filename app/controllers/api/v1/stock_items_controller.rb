# require './services/stock_management_service'

module Api
	module V1
		class StockItemsController < ApplicationController
      before_action :find_store_and_product, only: [:create]

      def index
				@stock_items = StockItem.all

				render json: @stock_items
			end

      def create
        @stock_item = StockItem.new(stock_items_params)
        if @stock_item.save
          render json: { message: 'Estoque criado!', data: @stock_item }, status: :ok
        else
          render json: { message: 'Erro ao criar estoque', data: @stock_item.errors }, status: :unprocessable_entity
        end
      end

      def update
        @service = StockManagementService.new(params[:stock_item_id], params[:amount])
        response = @service.update_stock(params[:operation])

				if response
					render json: { message: 'Estoque atualizado', data: response }, status: :ok
				else
					render json: { message: 'Erro ao atualizar o estoque!', data: response }, status: :unprocessable_entity
				end
      end

      private

      def store
        @store ||= Store.find_by(id: params[:store_id])
      end

      def product
        @product ||= Product.find_by(id: params[:product_id])
      end

      def find_store_and_product
        not_found unless store && product
      end

      def not_found
        render json: { status: 'Produto ou loja não encontrados' }, status: :not_found
      end

      def stock_items_params
        params.require(:stock_item).permit(:product_id, :store_id, :amount)
      end
    end
  end
end
