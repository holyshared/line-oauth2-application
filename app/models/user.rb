class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => %i(line)

  has_many :identities

  before_validation do
    self.password = SecureRandom.hex(8) if password.blank?
  end

  class << self
    def reconfirmable
      false
    end
  end

  def email_required?
    email.present?
  end

  def register_by_auth_provider!(auth)
    registered_identity = Identity.find_by_oauth_provider(auth)
    return registered_identity.user if registered_identity.present?
    ApplicationRecord.transaction do
      Identity.register!(self, auth)
    end
  end
end
