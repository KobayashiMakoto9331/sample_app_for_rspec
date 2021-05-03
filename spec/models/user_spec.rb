require 'rails_helper'

RSpec.describe User, type: :model do

  it "is invalid with a duplicate email adress" do
    User.create(password: 'password',
                password_confirmation: 'password',
                email: 'admin@example.com')

    user = User.new(password: '12345678',
                    password_confirmation: '12345678',
                    email: 'admin@example.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a password, password_confirmation, email" do
    user = User.new(password: 'password',
                    password_confirmation: 'password',
                    email: 'admin@example.com')
    expect(user).to be_valid
  end

  it "is invalid with a password" do
    user = User.new(password: nil,
                    password_confirmation: 'password',
                    email: 'admin@example.com')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 3 characters)")
  end

  it "is invalid with a password_confirmation" do
    user = User.new(password: 'password',
                    password_confirmation: 'pass',
                    email: 'admin@example.com')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "is invalid with a email" do
    user = User.new(password: 'password',
                    password_confirmation: 'password',
                    email: nil )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

end
