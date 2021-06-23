require 'rails_helper'

RSpec.describe Client, type: :model do
  
  subject { create :client }
  
  describe '#generate_token' do  
    it 'generates a valid login token' do
      token = subject.generate_token
      auth = Warden::JWTAuth::UserDecoder.new.call(token, :client, nil)
      expect(auth).to eq(subject)
    end
    it 'can\'t be used if it has been subsequently revoked' do
      token = subject.generate_token
      Client.revoke_jwt(nil, subject)
      expect{Warden::JWTAuth::UserDecoder.new.call(token, :client, nil)}.to raise_error(Warden::JWTAuth::Errors::RevokedToken)
    end
  end
  
end
