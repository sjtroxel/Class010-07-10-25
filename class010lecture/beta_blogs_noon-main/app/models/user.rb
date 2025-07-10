class User < ApplicationRecord
  has_many :blogs
  has_one :profile
  after_create :create_profile

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true
end
