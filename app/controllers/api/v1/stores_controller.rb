module Api
	module V1
		class StoresController < ApplicationController
			before_action :find_store, only: [:update, :destroy, :show]

			def index
				@stores = Store.all

				render json: @stores
			end

			def create
				@store = Store.create(store_params)
				build_address

				if @store.save
					render json: { message: 'Loja adicionada com sucesso!', data: @store.address }, status: :ok
				else
					render json: { message: 'Erro ao adicionar a loja', data: @store.errors }, status: :unprocessable_entity
				end
			end

			def update
				# TO DO
			end

			def show
				render json: { data: @store }, status: :ok
			end

			def destroy
				@store.destroy
				render json: { status: 'Loja atulizada' }
			end

			private

			def store
				@store ||= Store.find_by(id: params[:id])
			end

			def find_store
				store_not_found unless store
			end

			def store_not_found
				render json: { status: 'Loja não encontrada' }, status: :unprocessable_entity
			end

			def build_address
				address = params[:address_attributes]

				@store.build_address(
					store_id: @store.id,
					street: address[:street],
					number: address[:number],
					neighborhood: address[:neighborhood],
					city: address[:city],
					state: address[:state],
					zip: address[:zip]
				)
			end

			def store_params
				params.require(:store).permit(:name, :cnpj, { address_attributes: [:street, :number, :neighborhood, :city, :state, :zip] })
			end
		end
	end
end
