class ListsController < ApplicationController

  def index
    @lists = List.all

    def show
      @bookmark = Bookmark.new
      @movies = @list.movies
    end

    def new
      @list = List.new
    end

    def create
      @list = List.new(list_params)

      respond_to do |format|
        if @list.save
          format.html { redirect_to list_url(@list), notice: "List was successfully created." }
          format.json { render :show, status: :created, location: @list }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      if @list.destroy
        flash[:success] = 'List was successfully deleted.'
        redirect_to root_path
      else
        flash[:error] = 'Something went wrong'
        render 'show'
      end
    end

end


private

  def set_list
    @list = List.find(params[:id])
  end


  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
