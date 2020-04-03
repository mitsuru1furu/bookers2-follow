class BookCommentsController < ApplicationController
	before_action :baria_comment, only: [:destroy]

	def create
		book = Book.find(params[:book_id])
		if comment = current_user.book_comment.new(book_comment_params)
			comment.book_id = book.id
			comment.save
			redirect_to book_path(book)
		else
			render 'show'
		end
	end
	def destroy
		book = Book.find(params[:book_id])
		comment = current_user.book_comment.find_by(params[:comment])
		comment.destroy
		redirect_to book_path(book)
	end
	private
	def book_comment_params
		params.require(:book_comment).permit(:comment, :book_id, :user_id)
	end
	def baria_comment
  	unless params[:id].to_i == current_user.id
  		redirect_back(fallback_location: books_path)
  	end
  end
end
