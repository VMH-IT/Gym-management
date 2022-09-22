module Api
    module V1
        module Users
            class AdminsController < ApplicationController

                def index 
                    @admin = Admin.all
                    render json: @admin  
                end
                def show
                    unless current_user
                      return render json: {
                        message: 'you need to sign in'
                      }, status: 403
                    end
                
                    user = User.find(params[:id])
                
                    render json: @user
                  end

                def create
                    @admin = Admin.new(admin_params)
                
                    if @admin.save
                    # adminMailer.account_activation(@admin).deliver_now
                    render json: {
                        message: 'success',
                        token: ::JsonWebToken.encode({
                                                    sub: @admin.id
                                                    })
                    }
                    else
                    render json: {
                        message: 'failed'
                    }, status: 400
                    end
                end

                def sign_in
                    @admin = Admin.find_by(email: params[:email])
                    if @admin && @admin.valid?(params[:password])
                    render json: {
                        message: 'sucesss',
                        token: ::JsonWebToken.encode({
                                                    sub: @admin.id
                                                })
                    }
                    else
                    render json: {
                        message: 'failed' 
                    }, status: 400
                    end
                end
                def update
                    if @user.update(user_params)
                      render json: @user
                    else
                      render json: @user.errors, status: :unprocessable_entity
                    end
                  end
                  def destroy
                    @user.destroy
                  end
                private
                def admin_params
                    params.permit(:email, :password)
                end
            end
        end
    end
end
