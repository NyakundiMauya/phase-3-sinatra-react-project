# app.rb

require 'sinatra'
require 'sinatra/activerecord'

# Set up the database connection
set :database, { adapter: "sqlite3", database: "database.sqlite3" }

# Enable sessions to store admin authentication status
enable :sessions

# Define the Admin model
class Admin < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
end

# Home page
get '/' do
  erb :index
end

# Login page
get '/login' do
  erb :login
end

# Admin authentication
post '/login' do
  email = params[:email]
  password = params[:password]

  # Find the admin by email
  admin = Admin.find_by(email: email)

  if admin && admin.authenticate(password)
    # Store the admin ID in the session
    session[:admin_id] = admin.id
    redirect '/dashboard'
  else
    # Invalid credentials, redirect back to login page with an error message
    redirect '/login?error=1'
  end
end

# Dashboard page
get '/dashboard' do
  # Redirect to login if admin is not authenticated
  redirect '/login' unless session[:admin_id]

  # Find the admin by ID stored in the session
  @admin = Admin.find(session[:admin_id])
  
  erb :dashboard
end

# Logout
get '/logout' do
  session.clear
  redirect '/login'
end
get '/admin/books' do
    # Retrieve all books
    @books = Book.all
    erb :admin_books
  end
  
  get '/admin/books/:id' do |id|
    # Retrieve a specific book
    @book = Book.find(id)
    erb :admin_book
  end
  
  delete '/admin/books/:id' do |id|
    # Delete a specific book
    @book = Book.find(id)
    @book.destroy
    redirect '/admin/books'
  end
  
  post '/admin/books' do
    # Add a new book
    @book = Book.new(params[:book])
    if @book.save
      redirect '/admin/books'
    else
      erb :admin_add_book
    end
  end
  
  get '/admin/users' do
    # Retrieve all users
    @users = User.all
    erb :admin_users
  end
  
  get '/admin/users/:id' do |id|
    # Retrieve a specific user
    @user = User.find(id)
    erb :admin_user
  end
  
  get '/admin/reviews' do
    # Retrieve all reviews
    @reviews = Review.all
    erb :admin_reviews
  end
  
  # User routes
  get '/books/:id' do |id|
    # Retrieve a specific book for users
    @book = Book.find(id)
    erb :book
  end
  
  post '/books/:id/reviews' do |id|
    # Add a review for a specific book
    @book = Book.find(id)
    @review = Review.new(params[:review])
    @review.book = @book
    if @review.save
      redirect "/books/#{id}"
    else
      erb :book
    end
  end
  