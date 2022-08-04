describe LineItemsController do
  let(:user) { create(:user) }
  let(:market) { create(:market) }
  let(:product) { create(:product) }
  let(:cart) { Cart.create(user: user) }
  let(:line_item) { create(:line_item, cart: cart, product: product) }

  before { sign_in user }

  describe '#create' do
    subject { -> { post :create, params: params, format: :turbo_stream } }
    let(:params) { { product_id: product.id } }

    context 'add first product to cart' do
      let(:line_item) { cart.line_items.find_by(product: params[:product_id]) }

      it { expect(line_item).to be_nil }
      it { is_expected.to change { LineItem.count }.by(1) }
    end

    context 'add same product to cart' do
      it { is_expected.to change { line_item.reload.quantity }.from(1).to(2) }
    end

    context 'with invalid params' do
      let(:params) { { product_id: nil } }
      let(:line_item) { cart.line_items.find_by(product: params[:product_id]) }

      it { expect(line_item).to be_nil }
      it { is_expected.to_not(change { LineItem.count }) }
    end
  end

  describe '#update' do
    subject { -> { patch :update, params: params, format: :turbo_stream } }

    context 'update without id param' do
      let(:params) { { id: nil, operator: 'increment' } }

      it { is_expected.to raise_error }
    end

    context 'update with invalid operator param' do
      let(:params) { { id: line_item.id, operator: 'injection' } }

      it { is_expected.to_not change { line_item.reload.quantity }.from(1) }
    end

    context 'increase line_item quantity' do
      let(:params) { { id: line_item.id, operator: 'increment' } }

      it { is_expected.to change { line_item.reload.quantity }.from(1).to(2) }
    end

    context 'decrease line_item quantity' do
      let(:params) { { id: line_item.id, operator: 'decrement' } }

      it 'return if quantity is less than 2' do
        is_expected.to_not change { line_item.reload.quantity }.from(1)
      end

      it 'decrease if quantity is greater than 1' do
        line_item.increment!(:quantity)
        is_expected.to change { line_item.reload.quantity }.from(2).to(1)
      end
    end
  end

  describe '#destroy' do
    subject { -> { delete :destroy, params: params, format: :turbo_stream } }
    let(:params) { { id: line_item.id } }

    it { is_expected.to change { LineItem.count }.by(0) }
  end
end
