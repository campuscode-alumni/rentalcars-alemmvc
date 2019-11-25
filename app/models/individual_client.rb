class IndividualClient < Client
  validates :name, presence: true
  validates :email, presence: true
  validates :cpf, presence: true

  def client_description
    "#{self.name} | CPF: #{self.cpf} | #{self.email}"
  end
end
