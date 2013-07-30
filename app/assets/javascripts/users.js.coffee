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
    base = window.location.pathname
    if selected_id == 'member'
      action_path = base.concat('/invite-member')
    else
      action_path = base.concat('/invite-by-email')
    $('#invite-form').attr('action', action_path)


  $('#member').typeahead
    source: (query, process) ->
      $.get '/users/typeahead', name: query, (data) ->
        uidList = []
        window.uidMap = {}
        for item in data
          uidList.push(item.uid)
          window.uidMap[item.uid] = item
        process(uidList)
    matcher: (item) ->
      uidMap[item].name.match(new RegExp(this.query.trim(), 'i')) != null
    updater: (item) ->
      $('#uid').val(item)
      $('#invite-form').submit()
      window.uidMap[item].name
    highlighter: (item) ->
      name = window.uidMap[item].name
      '<div class="suggestion">' +
      '<img class="img-rounded" src="https://graph.facebook.com/' + item + '/picture">' +
      ' <span class="">' + name + '</span></div>'