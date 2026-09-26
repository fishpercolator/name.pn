require 'rails_helper'

RSpec.describe UserImage do
  describe '#profile_image' do
    ["O'Brien", 'Back\\slash', %q{Quote' text 0,0 'x}, '100%', '%w', '@/etc/hostname', ''].each do |name|
      it "draws a name badge for #{name.inspect}" do
        user = build :user, personal_name: name
        expect(user.profile_image.read).to start_with("\x89PNG".b)
      end
    end
  end
end
