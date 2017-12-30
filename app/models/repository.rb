class Repository < ApplicationRecord
  include HTTParty
  require "base64"

  has_many :packages, :dependent => :destroy
  def self.search(term)
    keyword = term.to_s.encode!("ASCII", invalid: :replace, undef: :replace, replace: "")
    return if keyword.blank?
    url = "https://api.github.com/search/repositories?q=#{keyword}+language:javascript&sort=stars&order=desc"
    response = HTTParty.get(url)
    response['items']
  end

  def self.store_packages(params, repository)
    url = "#{params['url']}/contents/package.json"
    response = HTTParty.get(url)
    return false if response["content"].blank?
    file_content = JSON.parse(Base64.decode64(response["content"]))
    dependencies = file_content["devDependencies"].keys || file_content["dependencies"].keys
    return false if dependencies.blank?
    dependencies.each do |name|
      repository.packages.create!({name: name})
    end
    return true
  end
end
