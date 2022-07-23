class Api::V1::OtpsController < Api::V1::BaseController

  def send_otp
    user = User.find_by phone_number: params[:phone_number]

    if user.present?
      render json: {
        status: 'fail',
        res: 'fail',
        message: "user has already been verified"
      }
    else
      otp = Otp.new(
        phone_number: params[:phone_number],
        code: "#{SecureRandom.random_number(10**6).to_s.rjust(6, '0')}",
        expired_at: Time.now + 2.minutes
      )
      if otp.save
        phone_number = otp.phone_number
        template_code = 1481704
        params = [otp.code, "2"]
        Qcloud::Sms.single_sender(phone_number, template_code, params)
        render json: {message: 'SMS with otp successfully sent', otp: otp}
      else
        render_error(otp)
      end
    end
    skip_authorization
  end

  def verify_otp
    otp = Otp.where(phone_number: params[:phone_number]).order(created_at: :desc).first

    if otp.present?
      if otp.code != params[:code]
        render json: {msg: 'Wrong OTP code'}
      elsif otp.expired_at < Time.now
        render json: { msg: 'OTP expired' }
      else
        otp.used = true
        otp.save!
        render json: { msg: 'OTP code matches. Success'}, status: 200
      end
    else
      render json: { msg: 'Phone number does not exist'}
    end
    skip_authorization
  end
end
