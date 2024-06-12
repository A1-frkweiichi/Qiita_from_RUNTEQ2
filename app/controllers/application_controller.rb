class ApplicationController < ActionController::Base
  def keep_awake
    head :ok
  end
end
