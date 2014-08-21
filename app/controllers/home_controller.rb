class HomeController < ApplicationController
  layout "home"
  helper_method :sort_column, :sort_direction, :per_page
  #before_filter :authenticate_user!
  def index
    @user = current_user

    @users = User.where({"users.role"=>"Candidate"})
    @comments = @user.comments if !@user.nil?
    if !@user.nil?
      @user.comments  << Comment.new unless @user.comments.nil?
    end

    max_pages = (@users.count / per_page.to_i).to_i + 1
    params[:page] = max_pages if params[:page].to_i > max_pages

    @users = @users.order(sort_column + ' ' + sort_direction).paginate(:per_page => per_page, :page => params[:page])

  end

  def resume
    @user = User.find(params[:user_id])
    @comments = @user.comments
    @users = User.where({"users.role"=>"Candidate"})
    render partial: "users/resume"
    #render partial: "home/home_after_login"
  end

  def comments_list
    @user = User.find(params[:user_id])
    @comments = @user.comments
    @users = User.where({"users.role"=>"Candidate"})
    render partial: "home/comments_list"
  end
  def add_comment
   @user = User.find(params[:comment][:user_id])
    @comment = Comment.new
    @comment.user_id = params[:comment][:user_id]
    @comment.name =params[:comment][:name]
    @comment.comment = params[:comment][:comment]
    @users = User.where({"users.role"=>"Candidate"})
    if @comment.save
      @comments = @user.comments
      render  "home/comments_list"
    end

  end

  def filter_users
    industry = params[:address][:industry]
    state = params[:address][:state]
    country = params[:address][:country]
    @users = User.joins(:address).where("addresses.industry=? and addresses.state =? and addresses.country =? and users.role !=? ", industry,state,country, 'Recruiter')
   # @users = User.find_by_sql("SELECT * FROM users INNER JOIN addresses ON addresses.user_id = users.id WHERE addresses.industry = '#{industry}'AND addresses.state = '#{state}' AND addresses.country = '#{country}' AND users.role != 'Recruiter' ")
    puts"=====#{@users.inspect}==="
    render  "users/users_list"
  end

  def show
  end

  private
  def sort_column
    params[:sort] || "users.id"
  end

  def sort_direction
    params[:direction] || "ASC"
  end

  def per_page
    params[:per_page] || 5
  end

end
