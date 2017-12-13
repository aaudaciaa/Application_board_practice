require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model.rb'

set :bind, '0.0.0.0'

enable :sessions

get '/' do
  @posts = Post.all.reverse
  erb :index
end

get '/write' do
  erb :write
end

get '/register' do #게시글 등록
  Post.create(
    :name => params["name"],
    :title => params["title"],
    :content => params["content"]
  )
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/join' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )

  redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
end

get '/login' do
  erb :login
end

get '/login_session' do
  @messge = ""
  if User.first(:email => params["email"]) #날라온 이메일로 가입된 사람이 있는지 없는지 확인
    if User.first(:email => params["email"]).password == params["password"]
      session[:email] = params["email"] # User.first(:email => params["email"])도 됨.
      #session은 해시이다. 여기 안에는 {:email = > "asdf@asdf.com"} 이 들어있다.
      @message = "로그인이 되었습니다."
      redirect to '/'
    else
      @message = "비번이 틀렸어요." #이메일은 DB에 존재하지만 비밀번호가 다른경우
    end
  else
    @messge = "해당하는 이메일의 유저가 없습니다."
  end
end

get '/logout' do
  session.clear
  redirect to '/'
end
