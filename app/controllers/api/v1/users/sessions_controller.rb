module Api
    module V1
        module Users
          class SessionsController < ApplicationController
            def create
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
          end
        end
    end
end
