require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET #show' do
    it "renders the :show template" do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end
end
