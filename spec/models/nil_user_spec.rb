require 'rails_helper'

describe NilUser do
  describe '#email' do
    it 'should be empty' do
      user = NilUser.new()

      expect(user.email).to eq ''
    end
  end

  describe '#role' do
    it 'should be visitor' do
      user = NilUser.new()

      expect(user.role).to eq 'visitor'
    end
  end

  describe '#admin' do
    it 'should be visitor' do
      user = NilUser.new()

      expect(user).not_to be_admin
    end
  end

  describe '#admin' do
    it 'should be visitor' do
      user = NilUser.new()

      expect(user).not_to be_admin
    end
  end
end