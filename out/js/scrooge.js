(function() {
  
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
;

  var gist, s3;

  gist = (function() {
    var ACCESS_TOKEN, GITHUB_URL, create, error, exports, fetch, list, success, _ACCESS_TOKEN;
    _ACCESS_TOKEN = "cd056fe085c2210e24cabcd088be7f9b0babd73e";
    ACCESS_TOKEN = "?access_token=" + _ACCESS_TOKEN;
    GITHUB_URL = "https://api.github.com/gists";
    list = function() {
      return $.ajax({
        url: "" + GITHUB_URL + ACCESS_TOKEN,
        type: 'GET',
        success: success,
        error: error
      });
    };
    fetch = function(id) {
      return $.ajax({
        url: "" + GITHUB_URL + "/" + id + ACCESS_TOKEN,
        type: 'GET',
        success: success,
        error: error
      });
    };
    create = function(payload) {
      return $.ajax({
        url: "" + GITHUB_URL + ACCESS_TOKEN,
        type: 'POST',
        data: {
          "public": false,
          files: {
            'request.json': {
              content: JSON.stringify(payload)
            }
          }
        },
        success: success,
        error: error
      });
    };
    success = function(response) {
      console.log(response);
      return true;
    };
    error = function(response) {
      console.log(response);
      return false;
    };
    return exports = {
      list: list,
      fetch: fetch,
      create: create
    };
  })();

  s3 = function(hash) {
    var S3_URL, SLEEP_INTERVAL, error, exports, poll, success, timeout;
    S3_URL = "http://scrooge.leknarf.net.s3-website-us-east-1.amazonaws.com/results/";
    SLEEP_INTERVAL = 500;
    timeout = None;
    poll = function() {
      return $.ajax({
        url: "" + S3_URL + hash + ".json",
        type: 'GET',
        success: success,
        error: error
      });
    };
    success = function(response) {
      console.log('Success!');
      console.log(response);
      clearTimeout(timeout);
      return response;
    };
    error = function(response) {
      console.log('Error!');
      console.log(response);
      timeout = setTimeout(poll, SLEEP_INTERVAL);
      return response;
    };
    return exports = {
      poll: poll
    };
  };

  window.scrooge = {
    gist: gist,
    s3: s3
  };

}).call(this);
