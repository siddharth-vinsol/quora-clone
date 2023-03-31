require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when user is not signed in' do
    it 'should be redirected to login path' do
      get :profile
      expect(response).to redirect_to(login_path)
    end
  end

  context 'when user is signed in' do
    before(:example) do
      user = create(:user)
      controller.instance_variable_set(:@logged_in_user, User.first)
    end

    it "should render profile template" do
      get :profile
      expect(response).to render_template('profile')
    end
  
    it "should render edit profile template" do
      get :edit
      expect(response).to render_template('edit')
    end

    it "should render edit password template" do
      get :password
      expect(response).to render_template('password')
    end

    it "should redirect back to other user profile page after follow or unfollow" do
      other_user = create(:user)
      post :follow, params: { username: other_user.username}
    end
  end
end
