require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:dogs).inverse_of(:owner) }
end
