describe 'the shopping cart process' do
  let!(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user) }
  let!(:product) { create(:product) }

  scenario 'user is sign in' do
    sign_in(user)
    expect(page.find('#header_cart_counter')).to have_text(0)

    visit cart_path(cart)
    expect(page).to have_text('Shopping Cart')
    expect(page).to have_text('0 Items')
    expect(page).to have_link('Continue Shopping')
    expect(page.find('#total_price')).to have_text(0)

    visit products_path
    click_button 'Add to cart'
    expect(page.find('#header_cart_counter')).to have_text(1)

    visit cart_path(cart)
    expect(page).to have_text('1 Items')
    expect(page.find('div.bg-transparent')).to have_text(1)
    expect(page.find('#total_price')).to have_text(10)
    expect(page).to have_button('Checkout')

    click_button '+'
    expect(page.find('#total_price')).to have_text(20)
    expect(page.find('div.bg-transparent')).to have_text(2)

    click_button '−'
    expect(page.find('#total_price')).to have_text(10)
    expect(page.find('div.bg-transparent')).to have_text(1)

    click_button 'Remove'
    expect(page.find('#header_cart_counter')).to have_text(0)
    expect(page).to have_text('0 Items')
    expect(page).to have_link('Continue Shopping')
    expect(page.find('#total_price')).to have_text(0)
    expect(page).to have_no_css('div.bg-transparent')
    expect(page).to have_no_text('Checkout')
  end

  scenario 'user is not sign in' do
    visit products_path
    click_link 'Add to cart'
    expect(current_path).to eq(new_user_session_path)

    visit cart_path(cart)
    expect(current_path).to eq(new_user_session_path)
  end
end
