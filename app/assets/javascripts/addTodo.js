$(document).on("turbolinks:load", function() {
    function addHTML(task) {
        var html = `
                    <tr>
                        <td>
                            ${ task.task }
                            <a href="/tasks/${ task.id }/edit">
                                <button>編集</button>
                            </a>
                            <a rel="nofollow" data-method="delete" href="/tasks/${ task.id }">
                                <button>削除</button>
                            </a>
                        </td>
                    </tr>
                    `
        return html;
    }

    function errMessage(err) {
        var errMsg = `<h3 style="color: red">${ err }</h3>`
        return errMsg;
    }

    $('.js-form').on('submit', function(e) {
        e.preventDefault();
        $('.error-message').empty();

        var formData = new FormData(this);
        var url = $(this).attr('action')

        $.ajax({
                type: 'POST',
                url: url,
                data: formData,
                dataType: 'json',
                processData: false,
                contentType: false
            })

            .done(function(data) {
                var html = addHTML(data);
                $('.tasklist-task').append(html);
                $('.js-form')[0].reset();
                $('.js-submit').prop('disabled', false);
              })
              .fail(function(xhr, status, error) {
                var html = errMessage(error);
                console.log(error);
                console.log(xhr);
                console.log(status);
                $('.error-message').append(html);
                $('.js-submit').prop('disabled', false);
              });
    });

});