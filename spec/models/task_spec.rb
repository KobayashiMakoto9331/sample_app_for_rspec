require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'validation' do

    #title, status がなければ無効であること
    it "is invalid with a title, status" do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    #titleがなければ無効であること
    it "is invalid with a title" do
      task_withoud_title = build(:task, title: nil)
      expect(task_withoud_title).to be_invalid
      expect(task_withoud_title.errors[:title]).to eq ["can't be blank"]
    end

    #statusがなければ無効であること
    it "is invalid with a status" do
      task_withoud_status = build(:task, status: nil)
      expect(task_withoud_status).to be_invalid
      expect(task_withoud_status.errors[:status]).to eq ["can't be blank"]
    end
    
    #重複したtitleは無効であること
    it "is invalid with a duplicate title" do
      task = create(:task, title: "same_tatle")
      task_with_duplicated_title = build(:task, title: "same_tatle")
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
    end

    #異なるtitleである時有効であること
    it "is valid with another title" do
      task = create(:task)
      task_with_another_title = build(:task, title: 'another_title')
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end

  end
end
