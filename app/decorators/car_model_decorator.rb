class CarModelDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def photo_url
    return polymorphic_url photo if photo.attached?
    # para o método acima funcionar, além de incluir os url_helpers
    # você vai precisar configurar o routes.default_url_options[:host]
    # no seu arquivp environments/test.rb

    'https://via.placeholder.com/150' # default photo
  end

  def manufacture_name
    return manufacture.name if manufacture
    'N/A'
  end
end