require 'rails_helper'

describe RentalHelper do
  describe '#status' do
    it 'should render green when ongoing' do
      # Arrange
      rental = build(:rental, status: :ongoing)
      # Act
      result = helper.status(rental)
      # Assert
      expect(result).to eq('<span class="badge badge-success">em andamento</span>')
    end

    it 'should render blue when scheduled' do
      # Arrange
      rental = build(:rental, status: :scheduled)
      # Act
      result = helper.status(rental)
      # Assert
      expect(result).to eq('<span class="badge badge-info">agendada</span>')
    end

    it 'should render gray when in review' do
      # Arrange
      rental = build(:rental, status: :in_review)
      # Act
      result = helper.status(rental)
      # Assert
      expect(result).to eq('<span class="badge badge-light">em revisão</span>')
    end

    it 'should render dark blue when finalized' do
      # Arrange
      rental = build(:rental, status: :finalized)
      # Act
      result = helper.status(rental)
      # Assert
      expect(result).to eq('<span class="badge badge-primary">finalizada</span>')
    end
  end
  
end