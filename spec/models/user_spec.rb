require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User class' do
    subject { User }

    it 'should include NotificationsHandler moudle' do
      expect(subject).to include(NotificationsHandler)
    end
  
    it 'should have png and jpeg as valid image mime type' do
      expect(subject::VALID_IMAGE_MIME_TYPES).to contain_exactly('image/png', 'image/jpeg')
    end
  end

  describe 'callbacks' do
    context 'when new user account created' do
      before(:all) do
        @user = create(:user)
      end

      after(:all) do
        @user.destroy
      end

      it 'should have confirmation token set' do
        expect(@user.confirmation_token).not_to be_nil
      end

      context 'when verified' do
        before(:all) do
          @user.verify
        end

        it 'should get credits' do
          expect(@user.credits).not_to be_zero
        end
  
        it 'should have auth token set' do  
          expect(@user.auth_token).not_to be_nil
        end

        it 'should generate a verification notification' do
          expect(@user.notifications.first.content).to eq('Your account has been verified and 5 credits have been rewarded.')
        end
      end
    end
  end

  describe 'validations' do
    context 'when user tries to signup' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :email }
      it { should validate_presence_of :username }
      it { should validate_confirmation_of :password }
      it { should validate_uniqueness_of :email }
      it { should validate_uniqueness_of :username }
      it { should validate_numericality_of :credits }

      it 'password should have atleast one Upper case letter, one special character, one digit and one lowercase letter and 8 characters' do
        @user = build(:user, password: 'password', password_confirmation: 'password')
        expect(@user.save).to be_falsey

        @user = build(:user, password: 'Pass', password_confirmation: 'Pass')
        expect(@user.save).to be_falsey

        @user = build(:user, password: '123', password_confirmation: '123')
        expect(@user.save).to be_falsey

        @user = build(:user, password: 'Pass@1234', password_confirmation: 'Pass@1234')
        expect(@user.save).to be_truthy
      end

      it 'should have valid email format' do
        @user = build(:user, email: 'abc')
        expect(@user.save).to be_falsey
        
        @user = build(:user, email: 'abc@quora-clone')
        expect(@user.save).to be_falsey

        @user = build(:user, email: '@quora-clone.com')
        expect(@user.save).to be_falsey

        @user = build(:user, email: 'user@quora-clone.com')
        expect(@user.save).to be_truthy
      end

      it 'should have valid profile image types' do
        @user = build(:user_with_png_profile_image)
        expect(@user.save).to be_truthy

        @user = build(:user_with_jpeg_profile_image)
        expect(@user.save).to be_truthy

        @user = build(:user_with_pdf_profile_image)
        expect(@user.save).to be_falsey
      end
    end
  end

  describe 'associations' do
    it { should have_many(:questions).class_name('Question') }
    it { should have_many(:credit_transactions).class_name('CreditTransaction') }
    it { should have_many(:orders).class_name('Order') }
    it { should have_and_belong_to_many(:followers).class_name('User') }
    it { should have_and_belong_to_many(:followees).class_name('User') }
    it { should have_many(:notifications).class_name('Notification') }
  end
end
