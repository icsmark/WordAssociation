class WordsController < ApplicationController
   def index
	if params[:search] 
#    	   @words = Word.search(params[:search]).order(score: :desc)
#	   @words = Word.find(params[:search]).find(:all, :conditions => ['word LIKE ?', "%#{params[:search]}"])
           @words = Word.where("word =  ?", params[:search].downcase).order(score: :desc).limit(10)
	else
           @words = Word.where("word like '%'").limit(10)
	end
   end

   def show
	Word.find(params[:id])
   end
	
   def remove_all
      Word.delete_all
      redirect_to books_path
   end

end
