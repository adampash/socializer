$ ->
  $('#domain_input').on 'keyup', ->
    $('.your-domain').text($('#domain_input').val())

    $('.feed_link').each (el) ->
      $(@).attr('href', $(@).text())
  $('#domain_input').focus()
