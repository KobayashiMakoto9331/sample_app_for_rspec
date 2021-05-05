require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  
    #ユーザーを作成する
    # user = User.create!(email:'admin@example.com', 
    #                     password:'password',
    #                     password_confirmation:'password')
    let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの正常値が正常' do
      it 'ログイン処理が成功' do
        login(user)
        expect(page).to have_content 'Login successful'
      end
    end
    context 'フォームが未入力'
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Login'
        expect(page).to have_content 'Login failed'
      end
    end
  

  describe 'ログイン後' do
    before { login(user) }
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        click_link 'Logout'
        expect(page).to have_content 'Logged out'
      end
    end
  end

end
