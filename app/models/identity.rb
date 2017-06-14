class Identity < ApplicationRecord
  belongs_to :user

  class << self
    def find_by_oauth_provider(auth)
      find_by(uid: auth['uid'], provider: auth['provider'])
    end

    def first_or_create_with_omniauth!(auth)
      where(uid: auth['uid'], provider: auth['provider']).first_or_initialize
    end
  end
end
