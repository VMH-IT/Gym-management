module Api
    module V1
        module Users
          class AccountActivationsController < ApplicationController
            def edit
                user = User.find_by(email: params[:email])
                if user && !user.activated? 
                  user.update_attribute(:activated,true)
                  user.update_attribute(:activated_at, Time.zone.now)
                  render json: {
                    message: "OK"
                  }
                else
                  render json: {
                    message: "not OK"
                  }
                end
            end
            end
        end
    end
end