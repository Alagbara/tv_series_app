class User < ActiveRecord::Base
    has_many :views
    has_many :series, through: :views

    
end
    
