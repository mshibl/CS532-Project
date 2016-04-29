require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'DELETE destroy' do
    before :each do
     session[:user_id] = 1;
    end

    it "deletes the user" do
      delete :destroy, id: session[:user_id]
      expect(session[:user_id]).to be_nil
    end

    it "routes delete destroy" do
      expect(:delete => "sessions/1").to route_to(:controller => "sessions", :action => "destroy", :id => "1")
    end
  end
end
