class TitterController < ApplicationController
  def top
    params[:session]|=nil
    flash[:notice]=nil
    flash[:ntice]=nil
    @all_tweet=Tweet5.all
    @all_like=Like.all
    if current_user
      @user_like=Like.where(user_id: current_user.id)
      @prof=Profile.find_by(user_id: current_user.id).message
    end
  end
  
  def login
    flash[:notice]=''
    user=User5.find_by(uid: params[:uid])
    puts user.uid
    if user!=nil
    p=BCrypt::Password.new(user.pass)
    if p==params[:pass]
      session[:login_uid]=params[:uid]
      redirect_to '/'
    end
    else
      flash[:noteice]='ユーザIDもしくは、パスワードが違います'
      render 'loginp'
    end
  end
  
  def regist
    flash[:notice]=''
    if current_user
      flash[:notice] ='別のユーザーidを入力してください'
      render 'regi'
    else
      if(params[:pass]==params[:password_confirmation])
      user = User5.new(uid: params[:uid],pass: BCrypt::Password.create(params[:pass]))
      user.save
      prof=Profile.new(user_id: user.id)
      prof.save
      session[:login_uid]=params[:uid]
      redirect_to '/'
      else
        flash[:notice] ='パスワードが違います'
      render 'regi'
      end
    end
  end
  
  def logout
    session[:login_uid]=nil
    redirect_to '/'
  end
  
  def new
    @tweet=Tweet5.new
  end
  
  def create
    @tweet=Tweet5.new(message: params[:tweet5][:message],user_id: current_user.id)
    if @tweet.save
    end
    redirect_to '/'
  end
  
  def like
    p=Like.new(user_id: current_user.id,tweet_id: params[:tid])
    p.save
    redirect_to '/'
  end
  
  def not_like
    Like.find(params[:lid]).destroy
    redirect_to '/'
  end
  
  def new_profile
    @profile=Profile.find_by(user_id: current_user.id)
  end
  
  def profile
    p=Profile.find_by(user_id: current_user.id)
    p.message=params[:profile][:message]
    p.save
    redirect_to '/'
  end
  
  def acdel
    Tweet5.where(user_id: current_user.id).destroy_all
    Like.where(user_id: current_user.id).destroy_all
    User5.find(current_user.id).destroy
    session[:login_uid]=nil
    redirect_to '/'
  end
  
  def twdel
    Tweet5.find(params[:tid]).destroy
    Like.where(tweet_id: params[:tid]).destroy_all
    redirect_to '/'
  end
end
