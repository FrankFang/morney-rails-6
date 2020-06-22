class Session
  include ActiveModel::Model
  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true

  validates_format_of :email, with: /.+@.+/, if: :email
  validates :password, length: {minimum: 6}, if: :password

end