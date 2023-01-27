class TopController < ApplicationController
    def index
        redirect_to tasks_path if user_signed_in?
    end
end