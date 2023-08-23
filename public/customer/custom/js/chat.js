$('#tailor-search-input').on('keyup', function (event) {
  const search = event.target.value;
  if (search !== '') {
    $.ajax({
      url: '/chats/search_tailor',
      method: 'POST',
      data: {
        search,
      },
      success: function (response) {
        $('#search-list').html(response);
        $('#search-list').removeClass('d-none');
        $('#contact-list').addClass('d-none');
      },
    });
  } else {
    $('#search-list').addClass('d-none');
    $('#contact-list').removeClass('d-none');
  }
});

function showChatHistory(userId) {
  $.ajax({
    url: `/chats/${userId}/get_chats`,
    method: 'POST',
    success: function (response) {
      $('#chat-history').html(response);
      $('#chat-history').removeClass('d-none');
      $('#tailor-list').addClass('d-none');
      $('.chat-content').scrollTop($('.chat-content')[0].scrollHeight);
      $('.chat-send #chat_text').keydown(function (event) {
        if (event.ctrlKey && event.keyCode == 13) {
          submitChat();
        }
      });
    },
  });
}

function showTailorList() {
  $('#chat-history').addClass('d-none');
  $('#search-list').addClass('d-none');
  $('#contact-list').removeClass('d-none');
  $('#tailor-list').removeClass('d-none');
  $('#tailor-search-input').val('');
  $.ajax({
    url: `/chats/contacts`,
    method: 'POST',
    success: function (response) {
      $('#contact-list').html(response);
    },
  });
}

function sendText(message) {
  var userId = $('.chat-send #chat_user_id').val();
  $.ajax({
    url: `/chats/${userId}/send`,
    method: 'POST',
    data: { message },
    success: function (response) {
      if (response.success) {
        $('.chat-send #chat_text').val('');
        showChatHistory(userId);
      }
    },
  });
}

function submitChat() {
  var chatMessage = $('.chat-send #chat_text').val();
  sendText(chatMessage);
}

function sayHi() {
  sendText('Hi.');
}

function acceptRequest() {
  var userId = $('.chat-send #chat_user_id').val();
  $.ajax({
    url: `/chats/${userId}/accept`,
    method: 'POST',
    success: function (response) {
      if (response.success) {
        showChatHistory(userId);
      }
    },
  });
}
