class RentalPresenter < SimpleDelegator
  delegate :content_tag, :link_to, to: :helper

  def initialize(rental)
    super(rental)
  end

  def status_badge()
    status_map = { "finalized" => 'primary', "scheduled" => 'success'}
    content_tag(:span, class: "badge badge-#{status_map[status()]}") do
      I18n.t(status).capitalize
    end
  end

  def next_action_link
    if __getobj__.scheduled?
      return link_to('Iniciar Locação', routes.review_rental_path(__getobj__))
    elsif  __getobj__.ongoing?
      return link_to('Finalizar Locação', routes.finish_rental_path(__getobj__))
    end
  end

  private
  def helper
    ApplicationController.helpers
  end

  def routes
    Rails.application.routes.url_helpers
  end
end