# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/forest.db")

class Post
  include DataMapper::Resource
  property :id, Serial #Question의 property를 id로 잡았고 그 데이터 타입은 Serial이다. 아래것도 마찬가지 원리
  property :name, String
  property :title, String
  property :content, Text
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :is_admin, Boolean, :default => false
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize # 위의 형태로 확실히 테이블을 만들께 하고 테이블 구조를 종결짓는 부분

# automatically create the post table
Post.auto_upgrade!
User.auto_upgrade!
