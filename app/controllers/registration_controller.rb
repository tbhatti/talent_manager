class RegistrationController < Devise::RegistrationsController
  layout "user_management"
  def new

    @user= User.new
    @address = Address.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation =params[:user][:password_confirmation]
     @address = Address.new
    if !params[:user][:resume].blank?

      @address.industry = params[:user][:address][:industry]
      @address.country = params[:user][:address][:country]
      @address.state = params[:user][:address][:state]
      @user.resume = params[:user][:resume]
      @user.name = @user.resume.name
      @user.email = @user.resume.email
      @user.role = "Candidate"
      @user.valid?
      if @user.errors.blank?
        @user.save
        @address.user = @user
        @address.save


        convert_to_png @user
        redirect_to  root_path
      else
        flash[:alert] = "Your CV is not Parsable...!"
        redirect_to  root_path
        #render :action => "new"
      end
    else
      @user.valid?
      if @user.errors.blank?
        @address.industry = params[:address][:industry]
        @address.country = params[:address][:country]
        @address.state = params[:address][:state]
        @user.role ="Recruiter"
        @user.save
        @address.user = @user
         @address.save
        redirect_to  root_path
      else
        if !params[:address].nil?
          render :action => "new"
        else
          flash[:alert] = "CV can not be Blank!"
          redirect_to  root_path
        end

       #
      end
    end

  end
  def edit
    render :edit
  end
  def convert_to_png user
    original_pdf = File.open("#{user.resume.path}", 'rb').read
    image = Magick::Image::from_blob(original_pdf) do
      self.format = 'PDF'
      self.quality = 100
      self.density = 144
    end
    image[0].format = 'JPG'
    image[0].to_blob

    image[0].write("public/#{user.resume.store_dir}" + "/#{user.resume.name}.jpg")
  end


end