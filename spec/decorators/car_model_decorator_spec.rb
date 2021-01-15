require 'rails_helper'

describe CarModelDecorator do
  describe '#car_options' do
    it 'should return an array' do
      car_model = build(:car_model, car_options: 'ar cond, android auto, gps')

      #car_model.car_options => ActiveRecord
      result = car_model.decorate.car_options #=> Versao Decorada

      expect(result.count).to eq 3
      expect(result).to include 'ar cond'
      expect(result).to include 'android auto'
      expect(result).to include 'gps'
    end
  end
end