#------------------------------------------------------------------------------
# app/serializers/blog_serializer.rb
#------------------------------------------------------------------------------
class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :summary, :posted

  belongs_to :user
end
