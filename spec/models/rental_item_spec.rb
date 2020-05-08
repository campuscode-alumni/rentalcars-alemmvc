require 'rails_helper'

RSpec.describe RentalItem, type: :model do
  describe 'associations' do
    it { should belong_to(:rental) }
    it { should belong_to(:rentable) }
  end
end
