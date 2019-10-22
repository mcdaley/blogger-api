#------------------------------------------------------------------------------
# config/routes.eb
#------------------------------------------------------------------------------
Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :blogs,   except: [:new, :update]
    end
  end

end
