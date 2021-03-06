# -*- encoding : utf-8 -*-
module APIHelpers

  def get_request_ip
    request.ip
  end

  def current_user
    if headers["Http-Access-Token"]
      token = headers["Http-Access-Token"]
    elsif (cookies[:remember_token])
      token = User.encrypt(cookies[:remember_token])
    end
    # remember_token = User.encrypt(token)
    @current_user ||= User.find_by(remember_token: token)
  end

  # 是否登录
  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

end
