(function() {
  var scrooge;

  scrooge = window.scrooge;

  $(document).ready(function() {
    return $("#demo_form").submit(function(event) {
      var payload, result;
      event.preventDefault();
      payload = $("#clientRequest").serializeObject();
      scrooge.gist.create(payload);
      result = scrooge.s3(Sha1.hash(payload));
      return result.poll();
    });
  });

}).call(this);
