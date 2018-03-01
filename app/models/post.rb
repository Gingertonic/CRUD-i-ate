class Post < ActiveRecord::Base

belongs_to :user

@@default_categories = [
  "funny",
  "kids",
  "gluttany",
  "moldy"
]

def slug
  self.title.parameterize
end

def self.find_by_slug(slug)
  self.all.find {|instance| instance.slug == slug}
end

def self.default_categories
  @@default_categories
end

# only shows current categories - not sure if useful but works
#def self.all_categories
#  self.all.map do |activity|
#    activity.category
#  end.uniq
#end

end
