require 'rails_helper'
# require 

RSpec.describe User, type: :model do
  describe 'Validations' do
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
      # p @new_user.errors
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(name: "name", email: "            email@test.com", password: "password", password_confirmation: "password")
    end
    it "validates there are no white spaces" do
    @new_user = User.create(name: "name", email: "   EMAIL@test.com   ", password: "password", password_confirmation: "password")
    expect(@new_user.email).to eq("   EMAIL@test.com   ")
      p @new_user.errors
    end
    it "validates there is a user returned" do
      @new_user = User.authenticate_with_credentials("   EMAIL@test.com   ", "password")
      expect(@user.errors).to be_empty
      # expect(@new_user.email).to eq("email@test.com")
      p "hello world", @new_user
    end
    it "validates there is a nil returned with empty parameters" do
      @new_user = User.authenticate_with_credentials("", "")
      expect(@new_user).to eq(nil)
    end
end


end

# how to save emails regardless of whitespaces and case sensitivity
