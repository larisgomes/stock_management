require 'rails_helper'

RSpec.describe Api::V1::StockItemsController, type: :controller do
  describe 'POST /api/v1/stock_items' do
    let(:product) { create(:product) }
    let(:store) { create(:store) }
    subject { response }

    context 'with valid params' do
      let(:params) do
        {
            product_id: product.id,
            store_id: store.id,
            stock_item: {
              product_id: product.id,
              store_id: store.id,
              amount: 10
            }
        }
      end

      let(:resp_body) { JSON.parse(response.body) }

      it 'returns 200 with the stock_item data' do
        post :create, params: params, format: :json

        expect(response.status).to eq(200)
        expect(resp_body['data']).to include('id', 'amount', 'store_id', 'product_id')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
            product_id: product.id,
            store_id: store.id,
            stock_item: {
              product_id: product.id,
              store_id: store.id,
              amount: -10
            }
        }
      end

      let(:resp_body) { JSON.parse(response.body) }

      it 'returns 422 with the error that occurred' do
        post :create, params: invalid_params, format: :json

        expect(response.status).to eq(422)
        expect(resp_body['message']).to eq( 'Erro ao criar estoque')
      end
    end
  end

  describe 'GET /api/v1/stock_items' do
    context 'when exists stocks' do
      let(:resp_body) { JSON.parse(response.body) }

      it 'returns a list of stocks' do
        get :index

        expect(resp_body.first).to include('id', 'store_id', 'product_id', 'amount', 'created_at', 'updated_at')
        expect(response.status).to eq(200)
      end
    end

    context 'when theres no stocks' do
      before do
        expect(StockItem).to receive(:all).and_return([])
      end

      it 'returns an empty array' do
        get :index

        expect(response.body).to eq('[]')
        expect(response.status).to eq(200)
      end
    end
  end
end
