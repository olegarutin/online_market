describe LineItem do
  let(:line_item) { create(:line_item) }

  describe '#total_price' do
    subject { line_item.total_price }

    it { is_expected.to eq(10) }
  end
end
