# #####################
# TODO: clean this up
`
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
`
###############

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
    $.ajax
      url: "#{GITHUB_URL}#{ACCESS_TOKEN}"
      type: 'POST'
      data:
        public: false
        files:
          'request.json':
            content: JSON.stringify(payload)
      success: success
      error: error

  success = (response) ->
    console.log response
    return true

  error = (response) ->
    console.log response
    return false

  exports =
    list: list
    fetch: fetch
    create: create

s3 = (hash) ->
  S3_URL = "http://scrooge.leknarf.net.s3-website-us-east-1.amazonaws.com/results/"
  SLEEP_INTERVAL = 500 # milliseconds
  timeout = None # timeout object

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
