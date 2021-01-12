module RentalHelper
  def rental_status(rental_status)
    status = { 'finalized' => 'success', 'scheduled' => 'primary', 'ongoing' => 'info', 'in_review' => 'warning' }
    content_tag(:span, class: "badge badge-#{status[rental_status]}") do
      t(rental_status).capitalize
    end
  end
end