require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    before do
      @user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
    end

    it 'is valid with valid information' do
      expect(@user).to be_valid
    end

    it 'is not valid without a password' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'is not valid if password and password_confirmation do not match' do
      @user.password_confirmation = 'different'
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is not valid if password is less than 6 characters' do
      @user.password = 'test'
      @user.password_confirmation = 'test'
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'is not vaild without an email' do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with an already used email - case insensitive' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
      user.save

      @user.email = 'TEST@test.com'

      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("has already been taken")
    end

    it 'is not valid without a first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'is not valid without a last name' do
    @user.last_name = nil
    expect(@user).to_not be_valid
    expect(@user.errors[:last_name]).to include("can't be blank")
    end
  end   

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    before do
      @user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
      @user.save
    end

    context 'when given valid email and password' do
      it 'return the user instance' do
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'test123')
        expect(authenticated_user).to eq(@user)
      end
    end

    context 'when given invalid password' do
      it 'return nil' do
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'test')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when given invalid email' do
      it 'return nil' do
        authenticated_user = User.authenticate_with_credentials('toot@test.com', 'test123')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when few spaces are before or after email' do
      it 'return the user instance' do
        authenticated_user = User.authenticate_with_credentials('  test@test.com  ', 'test123')
        expect(authenticated_user).to eq(@user)
      end
    end

    context 'when given email with different case' do
      it 'return the user instance' do
        authenticated_user = User.authenticate_with_credentials('tEst@test.COM', 'test123')
        expect(authenticated_user).to eq(@user)
      end
    end

  end
end
