
$(document).on 'keypress', '[id~=en_text]', (event) ->
  if event.keyCode is 13
    english = document.getElementById('en_text').value
    japanese = ""
    
    fromLang = 'en'
    toLang = 'ja'
   
    URL = 'https://translation.googleapis.com/language/translate/v2?key=' + gon.qrw_dfeoxjhummk876r + '&q=' + encodeURI(english) + '&source=' + fromLang + '&target=' + toLang
    xhr = new XMLHttpRequest
    xhr.open 'POST', [ URL ], false
    xhr.send()
    if xhr.status == 200
     res = JSON.parse(xhr.responseText)
     japanese =  res['data']['translations'][0]['translatedText']
    
    document.getElementById('ja_text').value = japanese
    document.getElementById('english').value = english
    document.getElementById('japanese').value = japanese
    