class OtpPolicy < ApplicationPolicy
  def send_otp?
    true
  end

  def verify_otp?
    true
  end

end
