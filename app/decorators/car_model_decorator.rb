class CarModelDecorator < Draper::Decorator
  delegate_all

  def car_options
    super.split(', ')
  end

  def photo
    if super.attached?
      super
    else
      'Foto Não Disponível'
    end
  end
end