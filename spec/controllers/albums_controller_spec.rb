require 'rails_helper'

RSpec.describe AlbumsController do
  describe 'GET #show' do
    it "renders the :show template" do
      album = create(:album)
      get :show, id: album
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new album to @album' do
      get :new
      expect(assigns(:album)).to be_a_new(album)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new album in the database" do
        expect{
          post :create, album: attributes_for(:album)
        }.to change(album, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new album in the database" do
        expect{
          post :create, album: attributes_for(:album, title: nil)
        }.to_not change(album, :count)
      end

      it "redirects to root" do
        post :create, album: attributes_for(:album, title: nil)
        expect(response).to redirect_to root_path
      end
    end
  end
end
