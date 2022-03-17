App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    user_name = $('[data-user]').attr('data-user')
    user_id = localStorage.getItem('user_id')
    @perform 'come_in', {user: user_name, user_id: user_id}
    

  disconnected: ->
    # Called when the subscription has been terminated by the server
    
  received: (data) ->
     console.log("Test out user!")
     if data["come_user"]
         if data["come_user_id"] != localStorage.getItem('user_id')
             user_name = data["come_user"]
             sentence = '<li data-user-id=' + data["come_user_id"] + '>' + user_name + '</li>'
             $('#user-list').append(sentence);
     else if data["out_user"]
         out_user = document.getElementById('user-list').querySelectorAll('[data-user-id="' + data[out_user_id] + '"]')
         out_user.remove()
     else
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
          sentence = '<div class="mymessage"><div class="messages"><p class="message message-en">' + message_en + '</p><p class="message message-ja">' + message + '</p></div></div>'
          
          $('#add-message').append(sentence);
         else
          sentence = '<div class="balloon6"><div class="user-name"><p>' + user_name + '</p></div><div class="chatting"><div class="says"><div class="messages-other">
          <p class="message message-en">' + message_en + '</p><p class="message message-ja">' + message + '</p></div>
          </div></div></div>'
          
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
    
    
window.onbeforeunload = ->
　#ページを離れる際にPoolテーブルからデータを削除
  
  return
