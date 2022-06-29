class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if resource.class == Admin
            root_path
        else
            resource # your path
        end
    end

    def after_sign_up_path_for(resource)
        worker_path(current_worker)
    end

    def authorize_admin
        redirect_back(fallback_location: root_path) unless current_admin
    end
end
