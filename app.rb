gem 'json', '~> 1.6'
require "sinatra"
require "sinatra/reloader"
require ".model.rb"

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


# CRUD - Read
# Variable routing을 통해서 특정한 게시글을 가져온다.

get '/posts/:id' do
    
    @id = params[:id] #특정한 아이디의 값을 가져옴 id Primary key
    @post=Post.get(@id) #DB에서 찾는다
    erb :'posts/show'
end

get '/posts/destroy/:id' do
 Post.get(params[:id]).destroy
 erb :'posts/destroy'
end

# 값을 받아서 뿌려주기 위한 용도
get '/posts/edit/:id' do
  @id = params[:id]
  @post = Post.get(@id)
  erb :'posts/edit'
end

get '/posts/update/:id' do
  @id = params[:id]
  Post.get(@id).update(title: params[:title], body: params[:body])
  redirect '/posts/'+@id
end