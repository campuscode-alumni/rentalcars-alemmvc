require 'rails_helper'

describe CarModelDecorator do
  describe '#photo_url' do
    it 'should return placeholder if empty' do
      car_model = build(:car_model, photo: nil)

      result = car_model.decorate.photo_url

      expect(result).to eq 'https://via.placeholder.com/150'
    end

    it 'should return photo url if has photo' do
      car_model = create(:car_model)
      photo_path = Rails.root.join('spec/support/car.jpg')
      car_model.photo.attach(io: File.open(photo_path), filename: 'car.jpg')
      car_model.save

      result = car_model.decorate.photo_url

      expected_regex = /\Ahttp:\/\/localhost\/rails\/active_storage\/blobs\/[\w\W]*\/car.jpg/
      expect(result).to match expected_regex
    end
  end

  describe '#manufacture_name' do
    it 'should render manufacture name' do
      manufacture = create(:manufacture, name: 'Fiat')
      car_model = build(:car_model, manufacture: manufacture)

      result = car_model.decorate.manufacture_name

      expect(result).to eq 'Fiat'
    end

    it 'should render N/A if manufacture' do
      car_model = build(:car_model, manufacture: nil)

      result = car_model.decorate.manufacture_name

      expect(result).to eq 'N/A'
    end
  end
end