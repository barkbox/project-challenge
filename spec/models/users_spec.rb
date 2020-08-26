require "rails_helper"

describe User do
  describe "#owner_of?" do
    subject { user.owner_of? dog  }

    let(:user) { create :user }

    context "when the user owns the dog" do
      let(:dog) { create :dog, user: user }
      it { is_expected.to be true }
    end

    context "when the dog belongs to another user" do
      let(:dog) { create :dog, user: create(:user) }
      it { is_expected.to be false }
    end
  end

  describe "#likes?" do
    subject { user.likes? dog }

    let(:dog) { create(:dog) }
    let(:user) { dog.user }

    it { is_expected.to be false }

    context "when a user has liked a dog" do
      before { create :like, user: user, dog: dog }
      it { is_expected.to be true }
    end
  end
end
