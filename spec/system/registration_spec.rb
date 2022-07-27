RSpec.describe 'the signin process', type: :system do
  let(:user) { build(:random_user) }

  it 'new user registration' do
    visit '/users/sign_up'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Create'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(page).to have_text(user.email)
  end
end
