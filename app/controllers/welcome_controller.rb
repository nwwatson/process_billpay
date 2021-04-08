# frozen_string_literal: true

class WelcomeController < ApplicationController

  def index
    redirect_to user_signed_in? ? batches_path : new_user_session_path
  end

  def terms; end

  def privacy; end
end
