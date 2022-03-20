document.addEventListener 'DOMContentLoaded', (->
  # 引数に指定したclassの値をもつ要素をすべて取得
  menus = document.getElementsByClassName('open')

  i = 0
  while i < menus.length
    menus[i].addEventListener 'click', ->
      # thisはli[i]にあたる
      trans = @.getAttribute('data-trans')
      if @.textContent == trans
        @textContent = "表示する"
      else
        @.textContent = trans
      return
    i++
  return
), false

