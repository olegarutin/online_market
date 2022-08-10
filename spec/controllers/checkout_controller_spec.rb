describe CheckoutController do
  let!(:user) { create(:user) }
  let!(:line_item) { create(:line_item, cart: cart) }
  let!(:cart) { create(:cart, user: user) }

  let(:stripe_customer) { Stripe::Customer.retrieve(user.stripe_customer_id) }
  let(:stripe_session) { Stripe::Checkout::Session.retrieve('test_cs_2') }

  before { sign_in user }

  describe '#create' do
    subject { post :create }

    it { expect(stripe_customer.email).to eq(user.email) }
    it { expect(Stripe::Customer.list.count).to eq(1) }
    it { subject; expect(stripe_session.customer).to eq(stripe_customer.id) }
  end
end
