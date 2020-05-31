class Api::V1::SessionsController < ApplicationController

  def sign_out
    current_store.authentication_token = nil

    current_store.save!

    render status: :ok
  end
end