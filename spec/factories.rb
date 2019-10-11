#------------------------------------------------------------------------------
# spec/factories.rb
#------------------------------------------------------------------------------
FactoryBot.define do
  
  #----------------------------------------------------------------------------
  # User Factories
  #----------------------------------------------------------------------------
  factory :user do
    first_name { "Fred" }
    last_name  { "Flintstone" }

    factory :user_with_blog_posts, :parent => :user do
      first_name  { "Barney" }
      last_name   { "Rubble" }

      after(:create) do |user, evaluator|
        create(:blog,     user: user)
        create(:blog_two, user: user)
      end
    end # end of factory :user_with_blog_posts
  end # end of factory :user

  #----------------------------------------------------------------------------
  # Blog Factories
  #----------------------------------------------------------------------------
  factory :blog do
    title   { "Blog Post Example" }
    summary { "Lorem ipsum" }
    posted  { 1.day.ago }
    user

    factory :blog_one, :parent => :blog do
      title   { "Blog Post One" }
      summary { "Wrestlemania" }
      posted  { 2.days.ago }
      user
    end

    factory :blog_two, :parent => :blog do
      title   { "Blog Post Two" }
      summary { "Killer Bees" }
      posted  { 3.days.ago }
      user
    end
  end # end of factory :blog

end # end of FactoryBot.define