class ApplicationController < ActionController::API

    private

    def current_user
      puts 'current user check'
      puts "token: #{request.headers['Authorization']}"
      token = request.headers['Authorization'].split('Bearer ').last
  
      puts "token: #{token}"
  
      decoded = JsonWebToken.decode(token)
  
      User.find(decoded['sub'])
    rescue StandardError => e
      nil
    end
end
