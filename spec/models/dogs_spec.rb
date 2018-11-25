require 'rails_helper'

RSpec.describe Dog, type: :model do
  it { should belong_to(:owner).class_name('User').with_foreign_key('user_id').optional }
end
