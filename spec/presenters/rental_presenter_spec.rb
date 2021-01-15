require 'rails_helper'

describe RentalPresenter do
  describe '#status_badge' do
    it 'should return a green badge if scheduled' do
      # 3A

      # Arrange => Preparar
      rental = build(:rental, status: :scheduled)

      # Act => Agir/Atuar/Executar
      result = RentalPresenter.new(rental).status_badge()

      # Assert => Garantir/Verificar
      expect(result).to eq('<span class="badge badge-success">Agendada</span>')
    end

    it 'should return blue badge if finalized' do
      rental = build(:rental, status: :finalized)

      result = RentalPresenter.new(rental).status_badge()

      expect(result).to eq('<span class="badge badge-primary">Finalizada</span>')
    end
  end

  describe '#next_action_link' do
    it 'should return review link if scheduled' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      manufacture = create(:manufacture)
      fuel_type = create(:fuel_type)
      category = create(:category, name: 'A', daily_rate: 50)
      customer = create(:individual_client, name: 'Claudionor',
                      cpf: '318.421.176-43', email: 'cro@email.com')
      car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                        fuel_type: fuel_type, category: category)
      car = create(:car, car_model: car_model, license_plate: 'TAT-1234')
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: '3000-01-08', end_date: '3000-01-10',
                      client: customer, price_projection: 100, status: :scheduled)

      result = RentalPresenter.new(rental).next_action_link

      expect(result).to include("Iniciar Locação")
    end

    it 'should return finalize link if ongoing' do
      
    end

  end

end