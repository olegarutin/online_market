describe OrdersController do
  let!(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user) }
  let!(:stripe_session) do
    StripeMock.create_test_helper.create_checkout_session(
      customer_details: { address: { city: '42nd street' }, email: user.email, phone: '123456789' },
      payment_status: 'paid'
    )
  end

  before { sign_in user }

  describe '#create' do
    subject { -> { get :create, params: params } }

    let(:params) { { session_id: stripe_session.id } }

    context 'with valid session' do
      it { is_expected.to change { Order.count }.from(0).to(1) }
      it { is_expected.to change { cart.reload.status }.from('in_progress').to('ordered') }
    end

    context 'with invalid session' do
      let(:stripe_session) do
        StripeMock.create_test_helper.create_checkout_session(customer_details: nil, payment_status: nil)
      end

      it { is_expected.to_not(change { Order.count }) }
      it { is_expected.to_not(change { cart.reload.status }) }
    end

    context 'withщге session id' do
      let(:params) { { session_id: nil } }

      it { is_expected.to_not(change { Order.count }) }
      it { is_expected.to_not(change { cart.reload.status }) }
    end
  end
end
