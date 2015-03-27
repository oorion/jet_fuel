class TitleWorker
  include Sidekiq::Worker

  def perform(url)
    connection = Faraday.new(url: url)
    response = connection.get
    body = response.body
    title = body.match(/(?<=<title>).*(?=<\/title>)/)[0]

    url_record = Url.find_by(original: url)
    url_record.update(title: title)
  end
end
