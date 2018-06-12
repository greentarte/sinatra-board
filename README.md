### Sinatra 정리

##### 준비사항

필수 gem 설치

`$ gem install sinatra`

`$ gem install sinatra-reloader`

##### 시작 페이지 만들기(routing 설징 및 View 설정)

```ruby
# app.rb
require 'sinatra'
require 'sinatra/reloader'

get '/' do  #routing '/'경로로 들어왔을때
    send_file 'index.html' # index.html 파일을 보내줘
end

get '/lunch' do # '/lunch' 경로로 들어왔을 때
    erb :lunch # views폴더 안에 있는 lunch.erb를 보여줘
end
```

##### Tip html:5 입력 후 tab키를 누르면 기본 html5기준 템플릿이 생성됨

##### params

1. variable routing

   ```ruby
   #app.rb
   get '/hello/:name'
   	@name = params[:name]
   	erb :name
   end
   ```



2. `form`tag를 통해서 받는 법

   ```HTML
   <form action="/posts/create">
       제목 : <input name="title">
       </form>
   ```

   ```ruby
   # app.rb
   # params
   # title("블라블라")
   get '/posts/create' do
      @title = params[:title]
   end
   ```

   

##### 폴더구조

- app.rb

- views/

  - erb

  - layout.erb  

    > layout.erb는  views폴더 상위에 있어야함



##### layout.erb

```erb
<html>
    <head>
        <body>
            <%= yield %>
        </body>
    </head>
</html>
```

```ruby
def hello
    puts "hello"
    yield
    puts "bye"
end
# {} : block / 코드 덩어리
hello{ puts "takhee"}
# => hello takhee bye
```



##### erb에서 루비 코드 활용하기

```ruby
# app.rb
get '/lunch' do
    @lunch = ["바스버거"]
    erb :lunch
end
```

```ruby
<!-- lunch.erb -->
<%= @lunch %>
```



##### 게시판 CRUD

C : Create

R : Read

U : Update

D : Delete

### ORM : object relation mapper

>데이터베이스와 **객체** 지향 프로그래밍 언어 간의 호환되지 않는 데이터를 변환하는 프로그래밍 기법이다. 

객체지향언어(ruby)와 데이터베이스(sqlite)를 연결하는 것을 도와주는 도구

[Datamapper]('http://recipes.sinatrarb.com/p/models/data_mapper')

##### 사전준비사항

`$ gem install datamapper`

`$ gem install dm-sqlite-adaper`

```ruby
# app.rb
# C9에서마 json의 라비브러리 충돌로 인한 코드
gem 'json', '~>1.6'
require 'datamapper'
#blog.db 세팅
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
#post 객체 생성
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
```



##### 데이터 조작

- 기본

  `Post.all`

- C(create)

  ```ruby
  # 첫번째 방법
  Post.create(title: "test", body: "test")
  
  # 두번째 방법
  p = Post.new
  p.title = "test"
  p.body = "test"
  p.save #db에 작성
  ```

- R(read)

  ```ruby
  Post.get(1) # get(id)
  ```

- U(update)

  ```ruby
  #첫번째
  Post.get(1).update(title: "test", body: "test")
  #두번째
  p = Post.get(1)
  p.title = "제목"
  p.body = "내용"
  p.save
  ```

- D(Destroy)

  ```ruby
  Post.get(1).destory
  ```



##### CRUD 만들기

Create : action이 두개 필요

```ruby
# 사용자에게 입력받는 창
get '/posts/new' do
end

# 실제로 db에 저장하는 곳
get 'posts/create' do
    Post.create(title: params[:title], body:params[:body])
end
```

Read: variable routing

```ruby
# app.rb
get 'posts/:id' do
 @post = Post.get(params[:id])
end
```



> layout.erb는 views폴더 밖에 위치해야함



# Bootstrap시작 

1. [statrt]('https://getbootstrap.com/docs/4.1/getting-started/introduction/')
   - CSS관련 태그 복사해서 붙여놓기
2. 기타 컴포넌트 및 구성요소 찾아서 복사 붙여넣기 후 수정해서 사용

##### bundler를 통한 gem 관리

> 어플리케이션의 의존성(dependency)를 관리해주는 bundler

1. bundler 설치

   `gem install bundler`

2. `Gemfile` 작성 : 루트 디렉토리에 만들기

   ```ruby
   source 'https://rubygems.org'
   gem 'sinatra'
   gem 'sinatra-reloader'
   gem 'datamapper'
   gem 'dm-sqlite-adapter'
   ```

3. `gem`설치

   `$ bundle install`



