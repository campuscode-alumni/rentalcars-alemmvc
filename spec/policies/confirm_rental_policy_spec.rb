require 'rails_helper'

describe ConfirmRentalPolicy do
  describe '#allowed?' do
    it 'should be true if admin' do
      user = build(:user, role: :admin)
      rental = build(:rental)

      result = described_class.new(user, rental).allowed?

      expect(result).to be true
    end

    it 'should be true if user subsidiary eq to rental subsidiary' do
      subsidiary = create(:subsidiary, name: 'Av Paulista')
      user = build(:user, role: :user, subsidiary: subsidiary)
      rental = build(:rental, subsidiary: subsidiary)

      result = described_class.new(user, rental).allowed?

      expect(result).to be true
    end

    it 'should be false if user subsidiary diff from rental subsidiary' do
      subsidiary = create(:subsidiary, name: 'Av Paulista')
      other_subsidiary = create(:subsidiary, name: 'Copacabana')

      user = build(:user, role: :user, subsidiary: subsidiary)
      rental = build(:rental, subsidiary: other_subsidiary)

      result = described_class.new(user, rental).allowed?

      expect(result).to be false
    end

  end
end