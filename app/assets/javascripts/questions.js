var ready = function () {

    $('.throw-question').click(function (e) {
        e.preventDefault();

        var sender_id = $(this).data('sid');
        var recipient_id = $(this).data('rip');
        window.setTimeout(function() {
        $.post("/questions", { sender_id: sender_id, recipient_id: recipient_id }, function (data) {
            // chatBox.chatWith(data.conversation_id);
        });
    }, 1500);
        
    });

}

$(document).ready(ready);
$(document).on("page:load", ready);