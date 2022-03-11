App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    user_name = $('[data-user]').attr('data-user')
    sentence = '<p>' + user_name + '</p>'
    $('#add-users').append(sentence);

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
     user_name = data["user"]
     current_user_id = localStorage.getItem('user_id')
     user_id = data["user_id"]
     
     
     message = data["message"]
     message_en = ""
     
     
     fromLang = 'ja'
     toLang = 'en'
     
     URL = 'https://translation.googleapis.com/language/translate/v2?key=' + gon.qrw_dfeoxjhummk876r + '&q=' + encodeURI(message) + '&source=' + fromLang + '&target=' + toLang
     xhr = new XMLHttpRequest
     xhr.open 'POST', [ URL ], false
     xhr.send()
     if xhr.status == 200
       res = JSON.parse(xhr.responseText)
       message_en =  res['data']['translations'][0]['translatedText']

     
     
     if current_user_id == user_id
      sentence = '<div class="row"><div class="col-md-6"></div>
      <div class="col-md-6"><p class="mb-0 pb-0" style="text-align: right; font-size: 20px;">' + message_en + '</p>
      <p style="text-align: right; font-size: 12px;">' + message + '</p></div></div>'
      $('#add-message').append(sentence);
     else
      sentence = '<div class="col-md-6">
      <p class="mb-0 pb-0">' + message_en + '</p>
      <p>' + message + '</p>
      </div>
      <div class="col-md-6"></div>'
      $('#add-message').append(sentence);
     
     list = document.getElementById('add-message')
     list.scrollTo 0, list.scrollHeight

  speak: (message, user, user_id) ->
    @perform 'speak', {message: message, user: user, user_id: user_id}

$(document).on 'keypress', '[data-behavior~=message_speaker]', (event) ->
  # return(Enter)が押された時
  if event.keyCode is 13
    #channel speakへ、event.target.valueを引数に
    App.message.speak event.target.value, $('[data-user]').attr('data-user'), $('[data-user_id]').attr('data-user_id')
    # inputの中身を空に
    event.target.value = ''
    event.preventDefault()