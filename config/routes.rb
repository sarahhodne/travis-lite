class OwnerNameContraint
  BLACKLIST = [
    "javascripts",
    "stylesheets",
    "assets",
  ].freeze

  def self.matches?(request)
    !new(request).blacklisted?
  end

  def initialize(request)
    @request = request
  end

  def blacklisted?
    BLACKLIST.any? { |blacklist_entry| blacklist_entry === owner_name }
  end

  private

  def owner_name
    @request.params[:owner_name]
  end
end

REPOSITORY_NAME_REGEXP = %r{[^/]+}

TravisLite::Application.routes.draw do
  get "jobs/show"
  resources :repositories, path: ':owner_name', only: :index, param: :name, constraints: OwnerNameContraint do
    member do
      get :show, name: REPOSITORY_NAME_REGEXP
    end
    resources :builds, only: %i[index show], repository_name: REPOSITORY_NAME_REGEXP
    resources :jobs, only: %i[show], repository_name: REPOSITORY_NAME_REGEXP
  end

  root "repositories#index"
end
