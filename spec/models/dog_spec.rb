require 'rails_helper'

RSpec.describe Dog, type: :model do
  let(:dog) {create( :dog)}

  describe '#likes_in_last_hour' do
    it 'should return 0 if the dog has no likes in last hour' do
      expect(dog.likes_in_last_hour).to eq(0)
    end

    it 'should return likes count if the dog has new likes in last hour' do
      5.times do
        user = create(:user)
        create(:like, user: user, dog: dog)
      end
      expect(dog.likes_in_last_hour).to eq(5)
    end
  end
end
