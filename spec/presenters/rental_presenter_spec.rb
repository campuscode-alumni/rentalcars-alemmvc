require 'rails_helper'

describe RentalPresenter do
  describe 'status_badge' do
    it 'should render green when ongoing' do
      # Arrange
      rental = build(:rental, status: :ongoing)
      # Act
      result = RentalPresenter.new(rental).status_badge
      # Assert
      expect(result).to eq('<span class="badge badge-success">em andamento</span>')
    end

    it 'should render blue when scheduled' do
      # Arrange
      rental = build(:rental, status: :scheduled)
      # Act
      result = RentalPresenter.new(rental).status_badge
      # Assert
      expect(result).to eq('<span class="badge badge-info">agendada</span>')
    end

    it 'should render gray when in review' do
      # Arrange
      rental = build(:rental, status: :in_review)
      # Act
      result = RentalPresenter.new(rental).status_badge
      # Assert
      expect(result).to eq('<span class="badge badge-light">em revisão</span>')
    end

    it 'should render dark blue when finalized' do
      # Arrange
      rental = build(:rental, status: :finalized)
      # Act
      result = RentalPresenter.new(rental).status_badge
      # Assert
      expect(result).to eq('<span class="badge badge-primary">finalizada</span>')
    end
  end
end