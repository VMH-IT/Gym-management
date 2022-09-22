
module Api
  module V1
    module Users
      class UsersController < ApplicationController
      before_action :set_user, only: %i[ show update destroy ]
    
      # GET /users
      def index
        @users = User.all
    
        render json: @users
      end
    
      # GET /users/1
      def show
        unless current_user
          return render json: {
            message: 'you need to sign in'
          }, status: 403
        end
    
        user = User.find(params[:id])
    
        render json: @user
      end
    
      # POST /users
      def create
        @user = User.new(user_params)
    
        if @user.save
          UserMailer.account_activation(@user).deliver_now
          render json: {
            message: 'success',
            token: ::JsonWebToken.encode({
                                          sub: @user.id
                                        })
          }
        else
          render json: {
            message: 'failed'
          }, status: 400
        end
      end

      def sign_in
        @user = User.find_by(email: params[:email])
        if @user && @user.valid?(params[:password])
          render json: {
            message: 'sucesss',
            token: ::JsonWebToken.encode({
                                         sub: @user.id
                                       })
          }
        else
          render json: {
            message: 'failed' 
          }, status: 400
        end
    end
    
      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /users/1
      def destroy
        @user.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def user_params
          params.permit(:name, :email, :password)
        end
        # Confirms the correct user
        def correct_user
          @user = User.find(params[:id])
          redirect_to(root_url) unless current_user?(@user)
          end
          # Confirms an admin user.
          def admin_user
          redirect_to(root_url) unless current_user.admin?
          end
    end
  end
  end
end

