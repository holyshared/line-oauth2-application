class Identity < ApplicationRecord
  belongs_to :user

  class << self
    def first_or_create_with_omniauth!(auth)
      where(uid: auth['uid'], provider: auth['provider']).first_or_create!
    end
  end
end