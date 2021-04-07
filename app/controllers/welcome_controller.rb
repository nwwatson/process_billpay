# frozen_string_literal: true

class WelcomeController < ApplicationController

  def index;
    redirect_to transactions_path if user_signed_in?
  end

  def terms; end

  def privacy; end
end
