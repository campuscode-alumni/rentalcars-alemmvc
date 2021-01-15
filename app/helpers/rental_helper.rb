module RentalHelper
  def rental_status(rental)
    status = { "finalized" => 'primary', "scheduled" => 'success'}
    content_tag(:span, class: "badge badge-#{status[rental.status]}") do
      t(rental.status).capitalize
    end
  end
end