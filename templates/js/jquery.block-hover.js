/*
USAGE

<div data-hover-block="true" style="border:1px solid blue;">
	test 1
	<br/>
	<div data-show="true" class="collapse" style="border:1px solid red;"><div style="padding:50px;">Test test test test test test</div></div>
	<a href="" class="btn btn-default">Button</a>
</div>

*/
(function( $ ) {
	$.fn.BlockHover = function() {
		var $container = $(this);
		var $blocks = $container.find("[data-show]");

		$container.hover(function () {
			if ($(window).width()>991 && !isTouchDevice()) {
	   			$blocks.slideDown(300);
			}
		}, function () {
			if ($(window).width()>991 && !isTouchDevice()) {
				$blocks.stop(true, false);
   				$blocks.slideUp(300);
			}
		});
	}
})(jQuery);

$(document).ready(function(){
	$("[data-hover-block]").each(function(){$(this).BlockHover();});
});
