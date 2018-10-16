class SessionsController < Devise::SessionsController
  def create
    super
    record_activity('log_in')
  end

  def destroy
    record_activity('log out')
    super
  end
end
