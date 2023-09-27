class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.page(params[:page])
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

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path(@user), notice: "User was successfully created." }
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
        format.html { redirect_to root_path(@user), notice: "User was successfully updated." }
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
      format.html { redirect_to root_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def search
    # Lấy từ khóa tìm kiếm từ params
    @search_term = params[:search_term]

    @users = User.where("name LIKE ? OR mentor LIKE ?", "%#{@search_term}%", "%#{@search_term}%")
    render :index
  end

  def approve_multiple
    selected_user_ids = approve_multiple_params[:user_ids]
    puts selected_user_ids
    if selected_user_ids.present?
      User.where(id: selected_user_ids).update_all(status: User.statuses[:approved])
      redirect_to users_path, notice: 'Users approved successfully.'
    else
      redirect_to users_path, alert: 'No users selected.'
    end
  end

  def reject_multiple
    selected_user_ids = approve_multiple_params[:user_ids]
    if selected_user_ids.present?

      User.where(id: selected_user_ids).update_all(status: User.statuses[:rejected])
    redirect_to users_path, notice: 'Users rejected successfully.'
    else
      redirect_to users_path, alert: 'No users selected.'
    end
  end
  def filter_by_payment
    @payment = params[:payment]

    if @payment  != "all"
      @users=User.where(payment:@payment)
      else if @payment =="all"
      @users=User.all

           end
      end


    # case payment
    # when "all"
    #   @users = User.all
    # when "paid"
    #   @users = User.where(payment: "paid")
    # when "not_paid"
    #   @users = User.where(payment: "not_paid")
    # else
    #   @users = User.all
    # end

    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :mentor, :skills, :payment, :time, :status)
    end

  def approve_multiple_params
    params.permit(user_ids: [])
  end
end
