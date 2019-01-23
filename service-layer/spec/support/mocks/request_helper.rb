module RequestHelper
  def stub_authorized_request(method, url)
    stub_request(method, url).
      with(
        headers: {
          "Authorization" => "Bearer #{ENV['CANVAS_TOKEN']}",
        },
      )
  end

  def stub_authorized_request_with_body(method, url, body)
    stub_request(method, url).
      with(
        body: body,
        headers: {
          "Authorization" => "Bearer #{ENV['CANVAS_TOKEN']}",
        },
      )
  end
end
