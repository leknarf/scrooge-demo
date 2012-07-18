gist = do ->
  # access_token for github user "scrooge-demo"
  _ACCESS_TOKEN = "cd056fe085c2210e24cabcd088be7f9b0babd73e"
  ACCESS_TOKEN = "?access_token=#{_ACCESS_TOKEN}"
  GITHUB_URL = "https://api.github.com/gists"

  list = ->
    $.ajax
      url: "#{GITHUB_URL}#{ACCESS_TOKEN}"
      type: 'GET'
      success: success
      error: error

  fetch = (id) ->
    $.ajax
      url: "#{GITHUB_URL}/#{id}#{ACCESS_TOKEN}"
      type: 'GET'
      success: success
      error: error

  create = (payload) ->
    console.log "Posting request to github"
    data = JSON.stringify
      public: false
      files:
        'request.json':
          content: payload
    $.ajax
      url: "#{GITHUB_URL}#{ACCESS_TOKEN}"
      type: 'POST'
      data: data
      success: success
      error: error

  success = (response) ->
    console.log response.responseText
    return true

  error = (response) ->
    console.log response.responseText
    return false

  exports =
    list: list
    fetch: fetch
    create: create

s3 = (hash) ->
  S3_URL = "http://scrooge.leknarf.net/results/"
  SLEEP_INTERVAL = 500 # milliseconds
  timeout = null # timeout object

  poll = ->
    $.ajax
      url: "#{S3_URL}#{hash}.json"
      type: 'GET'
      success: success
      error: error

  success = (response) ->
    console.log 'Success!'
    console.log response
    clearTimeout timeout
    return response

  error = (response) ->
    console.log 'Error!' # file doesn't exist yet
    console.log response
    timeout = setTimeout(poll, SLEEP_INTERVAL)
    return response

  exports =
    poll: poll

window.scrooge =
  gist: gist
  s3: s3
