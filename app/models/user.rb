#------------------------------------------------------------------------------
# app/models/user.rb
#------------------------------------------------------------------------------
class User < ApplicationRecord
  validates :first_name,  presence: true, length: { in: 1..128 }
  validates :last_name,   presence: true, length: { in: 1..128 }

  has_many  :blogs
end
