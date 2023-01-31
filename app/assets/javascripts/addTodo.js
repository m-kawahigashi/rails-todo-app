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

    $('.js-form').on('submit', function(e) {
        e.preventDefault();

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
              .fail(function() {
                alert('error')
                $('.js-submit').prop('disabled', false);
              });
    });

});