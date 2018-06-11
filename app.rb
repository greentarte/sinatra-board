gem 'json', '~> 1.6'
require "sinatra"
require "sinatra/reloader"
require 'data_mapper' # metagem, requires common plugins too.
# gem install datamapper
# gem install dm-sqlite-adapter
DataMapper::Logger.new($stdout,:debug)

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

before do
    p '----------------------------------'
    p params
    p '----------------------------------'
end

get '/' do
send_file 'index.html'
end

get '/lunch' do
    lunch=["짜장","짬뽕","20층"]
    @lunch=lunch.sample
    erb :lunch
end

#게시글을 모두 보여주는 곳
get '/posts' do
     @posts = Post.all
    erb :'posts/posts'
end

#게시글을 쓸 수 있는 곳
get '/posts/new' do
    erb :'posts/new'
end

get '/posts/create' do
    @title=params[:title]
    @body=params[:body]
    Post.create(title: @title, body: @body)
    erb :'posts/create'
end

#주요 메소드
#Post.first.destroy  --> 특정 1개의 행을 지운다.
# p = Post.new
# p.title = "제목"
# p.body = "내용"
# p.save --> insert가 됨
# post.get(id) id값이 맞는값을 1개 가져옴
# post.first(title:"123")