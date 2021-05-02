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
      task = build(:task, title: nil)
      expect(task).to be_invalid
      expect(task.errors[:title]).to include("can't be blank")
    end

    #statusがなければ無効であること
    it "is invalid with a status" do
      task = build(:task, status: nil)
      expect(task).to be_invalid
      expect(task.errors[:status]).to include("can't be blank")
    end
    
    #重複したtitleは無効であること
    it "is invalid with a duplicate title" do
      FactoryBot.create(:task, title: "same_tatle")
      new_task = FactoryBot.build(:task, title: "same_tatle")
      new_task.valid?
      expect(new_task.errors[:title]).to include("has already been taken")
    end

    #異なるtitleである時有効であること
    it "is valid with another title" do
      FactoryBot.create(:task)
      new_task = FactoryBot.build(:task)
      expect(new_task).to be_valid
    end

  end
end
