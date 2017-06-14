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
    def find_or_create_omniauth!(auth)
      registered_identity = Identity.find_by_oauth_provider(auth)
      return registered_identity.user if registered_identity.present?
      register_by_auth_provider!(auth)
    end

    def register_by_auth_provider!(auth)
      ApplicationRecord.transaction do
        identity = Identity.first_or_create_with_omniauth!(auth)
        user = User.create!(
          email: auth.info.email,
          identities: [identity]
        )
      end
    end

    def reconfirmable
      false
    end
  end

  def email_required?
    email.present?
  end
end
