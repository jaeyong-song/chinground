# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
    if event.keyCode is 13 #return(enter)
        App.chat.speak event.target.value
        # App.chat.speak를 통해서 server-side로 전송
        event.target.value = ''
        # 전송 후에는 텍스트 필드 값 삭제
        event.preventDefault()
        # form 중지