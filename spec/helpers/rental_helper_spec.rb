require 'rails_helper'

describe RentalHelper, type: :helper do
  describe '#rental_status' do
    it 'should return a green badge if scheduled' do
      rental = build(:rental, status: :scheduled)

      result = helper.rental_status(rental.status)

      # expect(result).to include('badge badge-success')
      # expect(result).to include('Agendada')
      expect(result).to eq('<span class="badge badge-primary">Agendada</span>')
    end

    it 'should return a blue badge if finalized' do
      rental = build(:rental, status: :finalized)

      result = helper.rental_status(rental.status)

      expect(result).to eq('<span class="badge badge-success">Finalizada</span>')
    end

    it 'should return a orange badge if in_review' do
      rental = build(:rental, status: :in_review)

      result = helper.rental_status(rental.status)

      expect(result).to eq('<span class="badge badge-warning">Em revisão</span>')
    end

    it 'should return a light blue badge if ongoing' do
      rental = build(:rental, status: :ongoing)

      result = helper.rental_status(rental.status)

      expect(result).to eq('<span class="badge badge-info">Em andamento</span>')
    end
  end
end