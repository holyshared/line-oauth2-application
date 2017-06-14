class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => %i(line)

  has_many :identities

  class << self
    def find_or_create_omniauth!(auth)
      registered_user = User.email(auth.info.email).first
      return registered_user if registered_user.present?

      user = nil
      ApplicationRecord.transaction do
        identity = Identity.first_or_create_with_omniauth!(auth)
        user = User.create!(
          email: auth.info.email,
          confirmed_at: Time.current,
          identities: [identity]
        )
      end
      user
    end

    def reconfirmable
      false
    end
  end
end
