require_relative '../models/author.rb'
require_relative '../models/book.rb'
require_relative '../models/user.rb'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get '/books' do
    books = Book.all
    books.to_json(include: :author)
  end
  get '/authors' do
    authors = Author.all
    authors.to_json
    
  end

  get '/users' do
    users = User.all
    users.to_json
  end


  post '/login' do
    user = User.find_by(email: params[:email])
    if user
      user.to_json
    else
      { message: "This user does not exist."}.to_json
    end
  end

  get '/books/:id' do
    books = Book.find(params[:id])
    books.to_json(include: :author)
  end


  post '/books' do
    books = Book.create(
        title: params[:title],
        author_id: params[:author_id], 
        summary: params[:summary],
        category: params[:category],
        image: params[:image],
       
    )
    books.to_json
  end

  post '/signin' do
    user = User.create(
        name: params[:name],
       user_id: params[:user_id], 
        email: params[:email],
        password: params[:password],
       
    )
    user.to_json
  end

  patch '/books/:id' do
    books = Book.find(params[:id])
    books.update(  
        title: params[:title],
        author_id: params[:author_id], 
        summary: params[:summary],
        category: params[:category],
        image: params[:image],
    )
    books.to_json
  end



  delete '/books/:id' do
    deleted = Book.find(params[:id])
    deleted.destroy
    deleted.to_json
  end



end
