class CodeClimateService
  attr_accessor :token, :github_slug
  
  def initialize(github_slug:, token:)
    self.token = token
    self.github_slug = github_slug
  end

  def fetch_repo
    url = 'https://api.codeclimate.com/v1/repos?'
    params = { github_slug: github_slug}
    final_url = url.concat(params.keys[0].to_s << "=" << params[:github_slug])
    uri = URI(final_url)
    req = Net::HTTP::Get.new(uri.request_uri)
    req['Accept'] = "application/vnd.api+json"
    req['Authorization'] = "Token " << token
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req)
      }
    raise ClimateError, "Code climate error" if (res.code != "200" || JSON.parse(res.body)["data"].blank?)
       
  end

  # def fetch_badge(url:)
  #   uri = URI(url)
  #   res = Net::HTTP.get_response(uri)
  # end
end