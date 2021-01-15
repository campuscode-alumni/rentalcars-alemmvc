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

  describe '#photo_url' do
    it 'should return default photo if not attached' do
      car_model = build(:car_model, photo: nil)

      result = car_model.decorate.photo_url

      expect(result).to eq 'https://place-hold.it/100x100'
    end

    it 'should return photo if attached' do
      car_model = create(:car_model)
      photo_path = Rails.root.join('spec/fixtures/150x150.png')
      car_model.photo.attach(io: File.open(photo_path), filename: '150x150.png')

      result = car_model.decorate.photo_url

      expect(result).to include '150x150.png'
      expect(result).to match(
        /\Ahttp:\/\/localhost\/rails\/active_storage\/blobs\/[\w\W]*\/150x150.png\z/
      )
    end
  end
end
