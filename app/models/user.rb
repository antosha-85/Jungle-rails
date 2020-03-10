class User < ActiveRecord::Base
    # attr_accessor :password_digest

    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates_length_of :password, minimum: 5
end
