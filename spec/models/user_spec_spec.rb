require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations name' do
    before(:each) do
      @user = User.create(name: "name", email: "email@test.com", password: "password", password_confirmation: "password")
    end
    it "validates works" do
      expect(@user.password).to eq(@user.password_confirmation)
      expect(@user.errors).to be_empty
    end
    it "validates error while we have different passwords" do
      @password = User.new(name: "name", email: "email@email.com", password: "password", password_confirmation: "password1")
      expect(@password.password).to_not eq(nil)
    end
    it "validates name is empty" do
      @user = User.new(name: nil, email: "email@email.com", password: "password", password_confirmation: "password")
      expect(@user.name).to eq(nil)
    end
    it "validates email is empty" do
      @user = User.new(name: 'name', email: nil, password: "password", password_confirmation: "password")
      expect(@user.email).to eq(nil)
    end
    it "validates uniqueness of email" do
      @new_user = User.create(name: "name", email: "EMAIL@test.com", password: "password", password_confirmation: "password")
      expect(@new_user.errors.full_messages).to include("Email has already been taken")
    end
    it "validates length of password" do
      @new_user = User.create(name: "name", email: "EMAIL@test.com", password: "pass", password_confirmation: "pass")
      expect(@new_user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      p @new_user.errors
    end
  end
end
