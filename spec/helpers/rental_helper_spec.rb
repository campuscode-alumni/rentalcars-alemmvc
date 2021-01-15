require 'rails_helper'

describe RentalHelper, type: :helper do
  describe '#rental_status' do
    it 'should return a green badge if scheduled' do
      rental = build(:rental, status: :scheduled)

      result = helper.rental_status(rental)

      #expect(result).to include('badge badge-success')
      #expect(result).to include('Agendada')
      expect(result).to eq('<span class="badge badge-success">Agendada</span>')
    end

    it 'should return blue badge if finalized' do
      rental = build(:rental, status: :finalized)

      result = helper.rental_status(rental)

      expect(result).to eq('<span class="badge badge-primary">Finalizada</span>')
    end
  end
end