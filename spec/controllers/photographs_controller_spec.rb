require 'rails_helper'

RSpec.describe PhotographsController do
  describe 'GET #show' do
    it "renders the :show template" do
      album = create(:album)
      photograph = create(:photograph, album: album)
      get :show, id: photograph, album_id: album.id
      expect(response).to render_template :show
    end
  end
end
