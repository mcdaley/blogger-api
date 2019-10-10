#------------------------------------------------------------------------------
# spec/factories.rb
#------------------------------------------------------------------------------
FactoryBot.define do
  factory :user do
    first_name { "Fred" }
    last_name  { "Flintstone" }
  end

  factory :blog do
    title   { "Blog Post One" }
    summary { "Lorem ipsum" }
    posted  { 1.day.ago }
  end
end