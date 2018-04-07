Rails.application.routes.draw do
  namespace 'api' do
    namespace 'version1' do
      resources :steps, only: [:index, :show],  param: :name
      get 'code/ruby'
      post 'code/ruby' => 'code#post_ruby',  param: :code
    end
  end
end