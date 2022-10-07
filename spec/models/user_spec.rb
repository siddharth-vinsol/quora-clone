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
          
        end
      end
    end
  end
end
