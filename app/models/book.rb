class Book < ActiveRecord::Base
    belongs_to :author
    has_many :reviews
    has_many :book_reads
    has_many :book_downloads
end
  