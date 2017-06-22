class Identity < ApplicationRecord
  belongs_to :user

  class << self
    def find_by_oauth_provider(auth)
      find_by(uid: auth['uid'], provider: auth['provider'])
    end

    def register!(user, auth)
      create!(user: user, uid: auth['uid'], provider: auth['provider'])
    end
  end
end
