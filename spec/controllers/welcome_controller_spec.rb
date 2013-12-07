require 'spec_helper'

describe WelcomeController do

  describe 'index page is root path' do

    before do
      get 'index'
    end

    it 'should return status=ok' do
      expect(response.ok?).to be(true)
    end

    it 'should show the welcome page' do
      expect(response).to render_template("index")
    end
  end

end
