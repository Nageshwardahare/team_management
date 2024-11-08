class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)

    if user.save
      success('Sign up successfully.', ActiveModelSerializers::SerializableResource.new(user, each_serializer: UserSerializer))
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
