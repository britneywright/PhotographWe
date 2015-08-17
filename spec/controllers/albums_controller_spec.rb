require 'rails_helper'

RSpec.describe AlbumsController do
  describe 'GET #show' do
    it "renders the :show template" do
      user = create(:user)
      album = create(:album, user: user)
      get :show, id: album, user_id: user.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new album to @album' do
      user = create(:user)
      get :new, user_id: user.id
      expect(assigns(:album)).to be_a_new(Album)
    end

    it 'renders the :new template' do
      user = create(:user)
      get :new, user_id: user.id
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      pending it "saves the new album in the database" do
        user = create(:user)
        expect{
          post :create, album: attributes_for(:album, user_id: user.id), user_id: user.id
        }.to change(Album, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new album in the database" do
        user = create(:user)
        expect{
          post :create, album: attributes_for(:album, name: nil), user_id: user.id
        }.to_not change(Album, :count)
      end

      it "renders the new template" do
        user = create(:user)
        post :create, album: attributes_for(:album, name: nil), user_id: user.id
        expect(response).to render_template :new, user_id: user.id
      end
    end
  end
end
