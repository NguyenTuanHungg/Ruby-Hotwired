class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index

    @users = User.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.js
      format.html
    end
    # @users=User.all
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
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@user) }
    end
  end
  def search
    # Lấy từ khóa tìm kiếm từ params
    @query= params[:query]

    @users = User.where("name LIKE ? OR mentor LIKE ?", "%#{@query}%", "%#{@query}%")

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

    if @payment.present? and @payment  != "all"
      @users=User.where(payment:@payment)
    else if @payment =="all"
      @users=User.all
           end
      end

    respond_to do |format|
      format.js   # Tạo một file filter_by_payment.js.erb
    end
  end

  def filter_by_status
    @status = params[:status]
    if @status.present? and @status != "all"
      @users = User.where(status: @status)
    end
    if @status == "all"
      @users = User.all
    end
    respond_to do |format|
      format.turbo_stream
      format.html

    end

  end

  def filter_by_date
    @date_from = params[:date_from]
    @date_to = params[:date_to]

    if @date_from.present? && @date_to.present?
      @users = User.where(time: @date_from..@date_to)
    else
      @users = User.all
    end

    respond_to do |format|
      format.js
    end
  end
  def filter
    @payment = params[:payment]
    @date_from = params[:date_from]
    @date_to = params[:date_to]

    @users = User.all
    @users = @users.by_payment(@payment) if @payment.present?
    @users = @users.by_date_range(@date_from, @date_to)

    respond_to do |format|
      format.js   # Tạo một file filter.js.erb
    end
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
