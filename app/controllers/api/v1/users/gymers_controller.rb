module Api
    module V1
        module Gymers
            class GymersController < ApplicationController
              
                def index 
                    @gymer = Gymer.all
                    render json: @gymer  
                end
                
                def show 
                end
              #get/api/v1/gymers/gymers
                def create
                    @gymer = Gymer.find_by(email: params[:email])
                    if @gymer && @gymer.valid?(params[:password])
                      render json: {
                        message: 'sucesss',
                        token: ::JsonWebToken.encode({
                                                     sub: @gymer.id
                                                   })
                      }
                    else
                      render json: {
                        message: 'failed' 
                      }, status: 400
                    end
                end
                private
                
            end
        end
    end
end