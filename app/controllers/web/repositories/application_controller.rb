# frozen_string_literal: true

class Web::Repositories::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
