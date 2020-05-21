module ControllerMacros

  def login_user
    before(:each) do
      user = FactoryBot.create(:user, email: 'user@gmail.com')

      sign_in user

      user
    end
  end
end
