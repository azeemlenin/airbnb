get '/' do
  # Look in app/views/index.erb

  erb :index
end

get '/create_user' do
  erb :create_user
end

post '/create_user' do
  # byebug
  @user = User.create(params[:users])
  if @user.valid?
    session[:user_id] = @user.id
    redirect to "/your_page"
  else
    redirect to "/create_user"
  end
end

get '/your_page' do
  if session[:user_id].nil?
    @user = User.all
    redirect to "/"
  else
    @user = User.find_by_id(session[:user_id])
    @property = @user.properties
    @tag = Tag.all
    erb :your_page
  end
end

get '/add' do
  @user = User.find_by_id(session[:user_id])
  erb :add
end

post '/add' do
  if session[:user_id].nil?
    redirect to "/"
  else
    @user = User.find_by_id(session[:user_id])
    @property = Property.new(property: params[:property])
    @tag = Tag.find_or_create_by(tag: params[:tag])
    if @property.save
      @user.properties << @property
      @tag.properties << @property
      redirect to "/your_page"
    else
      redirect to "/"
    end
  end
end

get '/homepage' do
  if session[:user_id].nil?
    @user = User.all
    redirect to "/"
  else
    @user = User.find_by_id(session[:user_id])
    @property = Property.all
    erb :homepage
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect to "/"
end

post '/login' do
  @user = User.where(email: params[:user][:email])
  @auth_result = @user.authenticate(params[:user][:email], params[:user][:password])
  if @auth_result == nil
    redirect to "/"
  else
    session[:user_id] = @auth_result.id
    redirect to "/your_page"
  end
end

delete '/delete' do
  @property = Property.find(params[:property][:id])
  # @user = User.find_by_id(session[:user_id])
  # @property = @user.properties
  @delete = @property.destroy

  redirect "/your_page"
end

get '/update/:id' do
  # byebug
  @property = Property.find_by_id(params[:id])
  @user = User.find_by_id(session[:user_id])
  erb :edit
end

put '/update/:id' do
  # byebug
  @property = Property.find_by_id(params[:id])

  @update = @property.update(property: params[:property])
  redirect "/your_page"
end

get '/details/:id' do
  @user = User.find_by_id(session[:user_id])
  @property = Property.find_by_id(params[:id])
  @tuan = @property.user
  erb :details
end

get '/tags/:id' do
  @tag = Tag.find_by_id(params[:id])
  @property = @tag.properties
  @user = User.find_by_id(session[:user_id])
  erb :oih
end