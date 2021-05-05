require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'タスクの新規登録ページにアクセス'do
        it 'タスクの新規登録ページへのアクセスに失敗' do
          visit new_task_path
          expect(page).to have_content "Login required"
        end
      end
      context 'タスクの編集ページにアクセス' do
        it 'タスクの編集が失敗' do
          visit edit_task_path(task)
          expect(page).to have_content "Login required"
        end
      end
      context 'タスクの詳細ページにアクセス' do
        it 'タスクの詳細ページが表示される' do
          visit task_path(task)
          expect(page).to have_content "Login"
          expect(page).to have_content "SignUp"
        end
      end
    end
  end

  describe 'ログイン後' do
  before { login(user) }

    describe 'タスク新規作成' do
      context 'フォームの入力値が正常'do
        it 'タスクの新規作成が成功' do
          visit new_task_path
          fill_in 'Title', with: 'task'
          fill_in 'Content', with: 'content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '002021-05-05-00:00'
          click_button 'Create Task'
          expect(current_path).to eq "/tasks/1"
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗' do
          visit new_task_path
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '002021-05-05-00:00'
          click_button 'Create Task'
          expect(page).to have_content "Title can't be blank"
        end
      end
      context '登録済みのタイトルを入力' do
        it 'タスクの新規作成が失敗'do
        visit new_task_path
        fill_in 'Title', with: task.title
        fill_in 'Content', with: 'content'
        select 'doing', from: 'Status'
        fill_in 'Deadline', with: '002021-05-05-00:00'
        click_button 'Create Task'
        expect(page).to have_content "Title has already been taken"
        end
      end
    end

    describe 'タスクの編集' do
      
      let!(:edit_task) { create(:task, user: user) }
      let!(:other_task) { create(:task, user: user) }
      before { login(user) }

      context 'フォームの入力値が正常'do
        it 'タスクの編集が成功' do
          visit edit_task_path(edit_task)
          fill_in 'Title', with: 'update_task'
          fill_in 'Content', with: 'update_content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '002021-05-05-00:00'
          click_button 'Update Task'
          expect(page).to have_content "Task was successfully updated."
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗' do
          visit edit_task_path(edit_task)
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'update_content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '002021-05-05-00:00'
          click_button 'Update Task'
          expect(page).to have_content "Title can't be blank"
        end
      end
      context '登録済みのタイトルを入力' do
        it 'タスクの新規作成が失敗' do
          visit edit_task_path(edit_task)
          fill_in 'Title', with: other_task.title
          fill_in 'Content', with: 'update_content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '002021-05-05-00:00'
          click_button 'Update Task'
          expect(page).to have_content "Title has already been taken"
        end
      end
    end

    describe 'タスクの削除' do
      let!(:task) { create(:task, user: user) }
      it 'タスクの削除が成功する' do
        visit tasks_path
        click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "Task was successfully destroyed."
      end
    end

  end
end
