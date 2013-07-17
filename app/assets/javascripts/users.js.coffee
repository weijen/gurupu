# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#member-type').change ->
    type = $('#member-type option:selected').val()
    selected_id = $('#member-type option:selected').val()
    unselected_id = $('#member-type option:not(:selected)').val()
    $("##{selected_id}").removeClass('hidden')
    $("##{unselected_id}").addClass('hidden')


  $('#uid').typeahead
    minLength: 2
    source: (query, process) ->
      $.get '/users/typeahead', name: query, (data) ->
        nameList = []
        for item in data
          nameList.push(item.name)
        process(nameList)
    updater: (item) ->
      console.log(item)
      item
    highlighter: (item) ->
      console.log this
      '<div class="suggestion"><img class="img-rounded" src="https://graph.facebook.com/100000134650492/picture">' +
      ' <span class="">' + item + '</span></div>'