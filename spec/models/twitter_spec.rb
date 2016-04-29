require 'rails_helper'


describe Twitter do
  describe '#create_access_token' do
    let(:user) {}
    let(:auth_token) {'1364692345-3O1cy5Qyd7gVZaVMAKpAS1k6vKZYmHDvI95amTw'}
    let(:auth_secret) {'NjNjZPmMXPFuFDjJ6qWpSw7lhToCxonDNgmYYKHgI9JqG5jZPmMXPFuFDjJ6qWpSw7lhToCxonDNgmYYKHgI9JqG5j'}
    let(:token) {Twitter.create_access_token(auth_token,auth_secret)}
    it "generates an OAuth::Token object" do
      expect(token).to be_kind_of(OAuth::Token)
    end
  end
end
