require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'POST /api/v1/products' do
    subject { response }

    context 'with valid params' do
      let(:params) do
        {
          product: {
            sku: '9090123456',
            name: 'pacocas',
            cost_price: 1.9
          }
        }
      end

      it 'returns 200 with the product data' do
        post :create, params: params, format: :json

        expect(response.status).to eq(200)
        expect(response.body).to include('id', 'name', 'cost_price')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          product: {
            name: 'bananas'
          }
        }
      end

      let(:resp_body) { JSON.parse(response.body) }

      it 'returns 422 with the error that occurred' do
        post :create, params: invalid_params, format: :json

        expect(response.status).to eq(422)
        expect(resp_body['message']).to eq( 'Erro ao criar o produto')
      end
    end
  end

  describe 'GET /api/v1/products/:id' do
    context 'when product is founded' do
      let(:product) { create(:product) }

      it 'returns 200' do
        params = { id: product.id }

        get :show, params: params
        expect(response.status).to eq(200)
      end
    end

    context 'when product is not found' do
      it 'returns 404' do
        params = { id: 2 }

        get :show, params: params
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'GET /api/v1/products' do
    context 'when exists products' do
      let(:resp_body) { JSON.parse(response.body) }

      before do
        create(:product)
      end

      it 'returns a list of products' do
        get :index

        expect(resp_body.first).to include('id', 'name', 'cost_price', 'created_at', 'updated_at')
        expect(response.status).to eq(200)
      end
    end

    context 'when theres no products' do
      before do
        expect(Product).to receive(:all).and_return([])
      end

      it 'returns an empty array' do
        get :index

        expect(response.body).to eq('[]')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'PUT /api/v1/products/:id' do
    context 'when product is founded' do
      let(:product) { FactoryBot.create(:product) }

      let(:update_params) do
        {
          id: product.id,
          product: {
            name: 'new name'
          }
        }
      end

      it 'update the product value' do
        put :update, params: update_params, format: :json

        product.reload
        expect(product.name).to eq('new name')
        expect(response.status).to eq(200)
      end
    end

    context 'when product is not founded' do
      let(:update_params) do
        {
          id: 99999,
          product: {
            name: 'new name'
          }
        }
      end

      it 'returns 404' do
        put :update, params: update_params, format: :json

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    context 'when product is founded' do
      let(:product) { create(:product) }

      it 'delete the product' do
        params = { id: product.id }

        delete :destroy, params: params, format: :json

        expect{ product.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response.status).to eq(200)
      end
    end

    context 'when product is not founded' do
      it 'returns 404' do
        params = { id: 99999 }

        delete :destroy, params: params, format: :json

        expect(response.status).to eq(404)
      end
    end
  end
end
