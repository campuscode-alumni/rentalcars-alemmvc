require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'associations' do
    it { should have_many(:car_models) }
    it { should have_many(:cars) }
    it { should have_many(:rental_prices) }
    it { should have_many(:insurances) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)  }
    it { should validate_presence_of(:daily_rate)  }
  end
end
