$(function() {
  $('.tab li').click(function() {

    $('.tab li').removeClass('select');

    $(this).addClass('select');

    $('.content li').addClass('hide');

    const index = $('.tab li').index($(this))
    $('.content li').eq(index).removeClass('hide');
  });
});
