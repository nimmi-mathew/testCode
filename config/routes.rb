Rails.application.routes.draw do
  namespace 'api' do
    namespace 'version1' do
      resources :steps, only: [:index, :show],  param: :name
     
      post 'code/ruby' => 'codes#post_ruby'
    end
  end
end