scrooge = window.scrooge

$(document).ready ->
  $("#demo_form").submit (event) ->
    event.preventDefault() #stop form submission
    payload = $("#clientRequest").serializeObject()
    scrooge.gist.create(payload)

    result = scrooge.s3(Sha1.hash(payload))
    result.poll()

