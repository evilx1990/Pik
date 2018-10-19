$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#newCategory').click ->
      if $('.new-cat').css('display') == 'none'
        $('.new-cat').css('display', 'inline-block')
      else
        $('.new-cat').css('display', 'none')
      return
    return
