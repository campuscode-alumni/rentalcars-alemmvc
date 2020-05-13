module RentalHelper

  STATUS_COLORS = { 'scheduled' => 'info',
                    'in_review' => 'light',
                    'ongoing' => 'success', 
                    'finalized' => 'primary' }

  def status(rental)
    css_class = STATUS_COLORS[rental.status]
    content_tag :span, class: ["badge badge-#{css_class}"] do
      t(rental.status)
    end
  end
end