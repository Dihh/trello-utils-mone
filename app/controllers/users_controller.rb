class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.boards = get_user_boards
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:key, :token)
    end

    def get_user_boards
      boards_response = HTTParty.get("https://api.trello.com/1/members/me/boards?key=#{@user.key}&token=#{@user.token}")
      boards = JSON.parse(boards_response.body)
      boards.map { |board|
          lists_response = HTTParty.get("https://api.trello.com/1/boards/#{board["id"]}/lists?key=#{@user.key}&token=#{@user.token}")
          lists = JSON.parse(lists_response.body)
          labels_response = HTTParty.get("https://api.trello.com/1/boards/#{board["id"]}/labels?key=#{@user.key}&token=#{@user.token}")
          labels = JSON.parse(labels_response.body)
          Board.new({
              name: board["name"],
              trello_id: board["id"],
              short_link: board["shortLink"],
              lists: lists.map { |list|
                List.new({
                  name: list["name"],
                  trello_id: list["id"],
                })
              },
              labels: labels.map { |label|
                Label.new({
                  name: label["name"],
                  trello_id: label["id"],
                })
              }
          })
      }
    end
end
