$(function(){
    $.each($(".icon-trash"), function() { $(this).attr('title', 'Удалить'); });
    $.each($(".icon-pencil"), function() { $(this).attr('title', 'Редактировать'); });
    $.each($(".icon-resize-vertical"), function() { $(this).attr('title', 'Сортировка'); });

    $.each($(".datepicker"), function() {
        $(this).datepicker({ dateFormat: "yy-mm-dd" });
        if (!$(this).val()) $(this).datepicker('setDate', new Date());
    });
    $('.js_delete').click(function(){
        if (confirm('Удалить?')) {
            var $el = $(this);
            $.ajax({
                url: $el.data('url'),
                success: function(ans) {
                    $el.closest('tr').remove();
                    var linked_del = $el.closest('tr').data('linked_del');
                    if (linked_del)
                        $('.js_linked_del_' + linked_del).remove();
                }
            });
        }
    });
    $('.js_editor').each(function(){
        var name = $(this).attr('name');
        CKEDITOR.replace(name, {
            toolbar : 'MyToolbar'
        });
    });
    $('.js_sortable').sortable({
        revert: true,
        handle: '.js_drag_grip',
        cursor: 'move',
        stop: function( event, ui ) {
            var arr = [];
            $(this).find('tr').each(function(i) {
                arr.push($(this).data('id'));
            });
            $.ajax({
                type: "POST",
                url: $(this).data('script') + "rearrange/",
                data: {
                    id: arr,
                },
                success: function(ans) {
                }
            });
        },
    });
});
