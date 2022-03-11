window.onload = ->
  num = document.getElementById('nickname').getAttribute('data-num');
  localStorage.setItem 'user_id', num
  document.getElementById( "btn" ).click();
return
