describe MarketsController do
  let(:market) { create(:market) }

  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status(200) }
  end

  context 'GET #show' do
    it 'should find and render marker' do
      get :show, params: { id: market.id }
      expect(response).to have_http_status(200)
    end
  end
end
