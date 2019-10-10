#------------------------------------------------------------------------------
# db/seeds.rb
#------------------------------------------------------------------------------

##
# Read the json file and parse data into hashes for blogs, users, and
# comments.
#
def parse_json_data(fname)
  json_data = JSON.parse(File.read(fname))
  return json_data
end

##
# Build the list of blog posts from the json data
#
def get_blog_posts(json_data)
  blog_posts = {}
  json_data.each do |record|
    blog = {
      id:         record["id"].to_i,
      title:      record["title"],
      summary:    record["summary"],
      posted:     DateTime.parse(record["posted"]),
      user_id:    record["author"]["id"]
    }
    blog_posts[blog[:id]] = blog
  end

  return blog_posts
end

##
# Load the blog posts into the DB
#
def load_blog_posts(blog_posts)
  Blog.delete_all

  i = 0
  blog_posts.each do |k, v|
    record = blog_posts[k]
    ## puts "DEBUG: #{record}"
    blog_post = Blog.new do |s|
      s.id      = record[:id]
      s.title   = record[:title]
      s.summary = record[:summary]
      s.posted  = record[:posted]
      s.user_id = record[:user_id]
      if s.save
        i = i + 1
      else
        puts "[ERROR] Failed to save blog post: #{s.errors.messages}" 
      end
    end
  end
  puts "[INFO] Saved #{i} blog posts to the DB"
end

##
# Get the users from the authors
#
# TODO:
# - Get users from the comments
#
def get_users(json_data)
  users = {}
  json_data.each do |record|
    author = {
      id:         record["author"]["id"].to_i,
      first_name: record["author"]["first_name"],
      last_name:  record["author"]["last_name"]
    }
    users[author[:id]] = author
  end

  return users
end

##
# Load the users into the DB
#
def load_users(users)
  User.delete_all

  i = 0
  users.each do |k, v|
    record = users[k]
    ## puts "DEBUG: #{record}"
    user = User.new do |s|
      s.id          = record[:id]
      s.first_name  = record[:first_name]
      s.last_name   = record[:last_name]
      if s.save
        i = i + 1
      else
        puts "[ERROR] Failed to save user: #{s.errors.messages}" 
      end
    end
  end
  puts "[INFO] Saved #{i} users to the DB"
end

#------------------------------------------------------------------------------
# main()
#------------------------------------------------------------------------------
json_data  = parse_json_data('./db/checkr-api.json')

users      = get_users(json_data)
load_users(users)

blog_posts = get_blog_posts(json_data)
load_blog_posts(blog_posts)
