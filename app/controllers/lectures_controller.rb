class LecturesController < ApplicationController
    def index
     @lectures = Lecture.all
    end
  
    def new
      @lecture = Lecture.new
    end
  
    def create
      @lecture = Lecture.new(lecture_params)
  
      if @lecture.save 
        redirect_to action: 'index'
      else 
        redirect_to action: 'new'
      end
    end

    private
    def lecture_params
      params.require(:lecture).permit(:name,:username, :overall,:level)
    end
  end
  


