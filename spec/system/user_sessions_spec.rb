require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  
  #ユーザーを作成する
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの正常値が正常' do
      it 'ログイン処理が成功' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq root_path
      end
    end
    context 'フォームが未入力'
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login failed'
        expect(current_path).to eq login_path
      end
    end
  

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login(user)
        click_link 'Logout'
        expect(page).to have_content 'Logged out'
        expect(current_path).to eq root_path
      end
    end
  end

end
