class User < ActiveRecord::Base
    validates :name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}, allow_blank:true
    validates_length_of :password, minimum: 5
    def self.authenticate_with_credentials(email, password)
        user = User.find_by_email(email)
        # If the user exists AND the password entered is correct.
        if user && user.authenticate(password)
            user
        else 
            nil
        end
    end 

    has_secure_password
end
