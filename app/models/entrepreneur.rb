class Entrepreneur < Client

  has_many :restaurants, dependent: :destroy
  has_many :restaurators

end
