module Admin
  class AdminController < ApplicationController
    before_action :require_admin! unless Rails.env.development?
  end
end
