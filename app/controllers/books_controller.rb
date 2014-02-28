class BooksController < ApplicationController
def new
	@book = Book.new
end

def show
	@book = Book.find(params[:id])
end

def create
	@book = Book.new(book_params)
	if @book.save
	   puts "Book is " + @book.content.length.to_s + " bytes"
	   puts @book.content.scan(/(\w|-)+/).size.to_s + " words"
	   words = @book.content.split(/\W+/)
	words.each_with_index { |val, idx| 
# update to insert all words between idx - 10 and idx + 10 with a score. The score is 10 - abs(idx - pos_of_word)
# model word word:string pos:integer neighbor: string score:integer book:references		
#		puts val.to_s + " " + idx.to_s + " " + @book.id.to_s

		# defina a range of ids
		if (idx<10)
		  rng = 0 .. (idx+10)
		else
		  rng = (idx-10) .. (idx+10)
		end
		# loop through that range
		rng.each do |np|
		# calculate score
			sc = 10 - (idx-np).abs
			nw = words[np] || ""
		# write to db if criterion met
			if val.length>3 and val != nw and nw.length>3 
# write to db 
		  		word  = Word.create(word: val.downcase, pos: idx, neighbor: nw.downcase, score: sc, book: @book)
			end	
		end
	}
	   redirect_to @book
	else
	   render 'new'
	end
end

def edit
	@book = Book.find(params[:id])
end

def update
  @book = Book.find(params[:id])
 
  if @book.update(params[:book].permit(:title, :content))
    redirect_to @book
  else
    render 'edit'
  end
end

def destroy
   @book = Book.find(params[:id])
   @book.destroy

   redirect_to books_path
end

def remove_all
   Book.delete_all
   redirect_to books_path
end

def index
	@books = Book.all
end

  def uploadFile
    post = DataFile.save(params[:upload])
    render :text => "File has been uploaded successfully"
  end

private
	def book_params
		params.require(:book).permit(:title, :content)
	end

end
