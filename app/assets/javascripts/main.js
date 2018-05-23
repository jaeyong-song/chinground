$('#new_message').on ('submit', function(){
    event.preventDefault();
    // make sure there is content
    if ($('#new_message [name="message[content]"]').val() === ""){
      return false;
    }

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      method: "post"
    }).done( function(res){
      // reset user input to empty
      $('#new_message [name="message[content]"]').val("");
    });
  });
});