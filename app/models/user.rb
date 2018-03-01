class User < ActiveRecord::Base
  has_many :activities
  has_secure_password
  validates_presence_of :username, :password

def slug
  self.username.parameterize
end

def self.find_by_slug(slug)
  self.all.find {|instance| instance.slug == slug}
end
end
