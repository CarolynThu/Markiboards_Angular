class BoardsController < ApplicationController
  def index
    @boards = Board.all
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])   
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(params.require(:board).permit(:name, :price, :description))
    if @board.save
      redirect_to boards_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
