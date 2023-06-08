class User < ActiveRecord::Base
    has_many :book_reads
    has_many :book_downloads
    has_many :reviews
  end
  