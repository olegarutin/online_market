describe 'the signin process' do
  let(:user) { create(:user) }

  it 'user login and logout' do
    visit root_path
    click_button 'Sign In'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'LOG IN'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text(user.email)
    click_button 'Sign Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed out successfully.')
    expect(page).to_not have_text(user.email)
  end
end
