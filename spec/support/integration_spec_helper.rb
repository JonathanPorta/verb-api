module IntegrationSpecHelper
  def login_with_oauth(service = :facebook)
    get "/auth/#{ service }"
    follow_redirect!
  end
end
