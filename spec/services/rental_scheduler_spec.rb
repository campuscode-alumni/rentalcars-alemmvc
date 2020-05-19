require 'rails_helper'

describe RentalScheduler do
  describe '#schedule' do 
    #subject { describe_class.new(rental).schedule() }

    it 'should not schedule without subsidiary' do
      rental = build(:rental, subsidiary: nil)

      result = RentalScheduler.new(rental).schedule

      expect(result).to eq false
    end

    it 'should schedule' do
      # Arrange
      category = create(:category, daily_rate: 99)
      client = create(:client)
      subsidiary = create(:subsidiary)
      car_model = create(:car_model, category: category)
      car = create(:car, car_model: car_model)

      rental = build(:rental, start_date: 1.day.from_now, end_date: 2.days.from_now,
                     category: category, client: client, subsidiary: subsidiary)

      #calculator_spy = class_spy('RentalCalculator')
      #stub_const('RentalCalculator', calculator_spy)
      
      #allow(calculator_spy).to receive(:calculate).with(rental).and_call_original
      expect(RentalCalculator).to receive(:calculate).with(rental).and_call_original

      # Act
      result = RentalScheduler.new(rental).schedule
      
      # Assert
      #expect(calculator_spy).to have_received(:calculate).with(rental)
      expect(result).to eq true
      expect(rental).to be_persisted
      expect(rental).to be_scheduled
      expect(rental.price_projection).to eq 99
    end
  end
end