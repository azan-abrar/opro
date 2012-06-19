class Opro::Oauth::ClientAppController < OproController
  before_filter :opro_authenticate_user!

  def new
    @client_app = Opro::Oauth::ClientApp.new
  end

  # Show all client applications belonging to the current user
  def index
    @client_apps = Opro::Oauth::ClientApp.where(:user_id => current_user.id)
  end


  def create
    @client_app = Opro::Oauth::ClientApp.find_by_user_id_and_name(current_user.id, params[:oauth_client_app][:name])
    @client_app ||= Opro::Oauth::ClientApp.create_with_user_and_name(current_user, params[:oauth_client_app][:name])
    if @client_app.save
      # do nothing
    else
      render :new
    end
  end

end