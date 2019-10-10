class Blog < ApplicationRecord
  validates   :title,   presence: true, length: {in: 1..128}
  validates   :summary, length: {in: 1..256}
  validates   :posted,  presence: true

  belongs_to  :user
end
