$(document).on "turbolinks:load", ->
  if $(".messages.index").length > 0
    App.message = App.cable.subscriptions.create "MessageChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
    
      disconnected: ->
        # Called when the subscription has been terminated by the server
        
      received: (data) ->
         current_user_id = document.getElementById('nickname').getAttribute('data-num')
         if data["come_user"]
             sentence = '<div class="come text-center text-success"><p class="come-message">「' + data["come_user"] + '」さんが入室しました。</p></div>'
             $('#add-message').append(sentence);
             if data["come_user_id"] != Number(current_user_id)
                 user_name = data["come_user"]
                 sentence = '<li id=' + data["come_user_id"] + '>' + user_name + '</li>'
                 $('#user-list').append(sentence);
         else if data["out_user"]
             out_user = document.getElementById(data["out_user_id"])
             out_user.remove()
             
         else
             if data["message"] != ""
                 user_name = data["user"]
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
    
    