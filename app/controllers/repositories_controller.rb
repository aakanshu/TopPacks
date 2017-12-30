class RepositoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /repositories
  # GET /repositories.json
  def index
    @search = []
    if params[:term].present?
      @search = Repository.search(params[:term])
    end
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
    @packages = @repository.packages
  end

  def edit
  end

  def create
    hash_params = get_params(params[:repo])
    @repository = Repository.create(hash_params)
    packages = Repository.store_packages(params[:repo], @repository)
    @repository.update_attributes!({has_packages: packages}) if packages
    respond_to do |format|
      format.html { redirect_to @repository, notice: 'Repository was successfully created.' }
      format.json { render :show, status: :created, location: @repository }
    end
  end

  def packages
    packages = Package.find_by_sql("Select packages.name, count(packages.name) as number from packages group by(packages.name) order by number desc")
    @packages = packages.first(10)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def repository_params
      params.fetch(:repository, {})
    end

    def get_params(param)
      return {name: param["name"], stars_count: param["stargazers_count"], forks_count: param["forks_count"], html_url: param["html_url"]}
    end
end
