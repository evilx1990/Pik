$(document).on 'turbolinks:load', ->

  $(document).ready ->
    $('.delete').on 'click', ->
      if confirm('Are your sure?')
        $.ajax
          url: '/categories/' + @parentElement.id
          type: 'DELETE'
          success: (r) ->
      return
    return
