window.onload = ->
  num = document.getElementById('nickname').getAttribute('data-num');
  localStorage.setItem 'user_id', num
return
