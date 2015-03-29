class TitleWorker
  include Sidekiq::Worker

  def perform(url)
    connection = Faraday.new(url: url)
    response = connection.get
    body = response.body
    body.match(/(?<=<title>).*(?=<\/title>)/)[0]
  end
end
