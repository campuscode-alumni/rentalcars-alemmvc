require 'rails_helper'

RSpec.describe Insurance, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)  }
    it { should validate_presence_of(:daily_rate)  }
    it { should validate_numericality_of(:daily_rate).is_greater_than(0) }
  end
end
