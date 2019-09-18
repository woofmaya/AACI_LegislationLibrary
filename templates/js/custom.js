$(document).ready(function() {
	/********** FORM PLACEHOLDER LABEL **********/
	$("form .form-group .input-wrap").each(function(){
		var $wrap = $(this);

		$wrap.find('.input-label').click(function() {
			$(this).next().focus();
		})

		$wrap.find('textarea').css('overflow', 'hidden').autogrow();

		$wrap.find('input[type="text"], input[type="email"], textarea')
			.focusin(function() {
				$wrap.addClass("has-content");
			})
			.focusout(function() {
				if (""+$(this).val()=="") $wrap.removeClass("has-content");
			});

	});
	/********** END FORM PLACEHOLDER LABEL **********/


	/********** SKIP MOBILE FOCUS **********/
	$("a").each(function(){
		var $a = $(this);
		$a.bind("touchstart", function(e) {
			return true;
		});
	});
	/********** END SKIP MOBILE FOCUS **********/

	/********** CLEAN EMPTY BLOCKS **********/
	$('h1, h2, h3, h4, h5, h6, .textbox').each(function(){
		if($(this).html()<=2){
			$(this).remove();
		}		
	});
	/********** END CLEAN EMPTY BLOCKS **********/


	/********** SCROLL UP BUTTON **********/
	$("#scrollup").click(function(){
		$("html, body").animate({ scrollTop: 0 }, 500);
		return false;
	});
	/********** END SCROLL UP BUTTON **********/


	/********** MOBILE NAV BUTTON **********/
	$("#mobile_nav_btn").click(function(){
		var b = $(this);
		var m = $(b.attr("data-target-custom"));
		if (m.hasClass("in")) {
			b.attr("aria-expanded","false");
			m.slideUp(400, function(){m.removeClass("in")});
		} else {
			b.attr("aria-expanded","true");
			m.slideDown(400, function(){m.addClass("in")});
		}
	});
	/********** END MOBILE NAV BUTTON **********/


	/********** NAV DROPDOWN **********/
	$("#main-nav .dropdown-toggle").click(function(e){
		var li = $(this).parent();
		var btn = $(this);

		if (li.hasClass("open")) {
			btn.next().attr("style","display:block");
			btn.attr("aria-expanded","false");
			btn.next().slideUp(400, function(){
				li.removeClass("open")
			});
		} else {
			/*$("#main-nav .nav > li.open").each(function(){
				var t = $(this);
				t.find(".dropdown-menu").slideUp(400, function(){
					t.removeClass("open");
					t.find(".dropdown-toggle").attr("aria-expanded", "false");
				});
			});*/

			btn.attr("aria-expanded","true");
			btn.next().slideDown(400, function(){
				li.addClass("open");
				btn.next().attr("style","");
			});
		}
	});
	/********** END NAV DROPDOWN **********/


	/********** NAV DROPDOWN HOVER**********/
	if ($(window).width()>991) {
		// open by hover
		$("#main-nav .dropdown_split").each(function(){
			var a = $(this).find("a:first");
			$(this).mouseenter(function(e){
				var btn = a.next(".dropdown-toggle");
				if (btn.attr("aria-expanded")=="false") btn.click();
			});
		});

		// close by move outside
		$("#main-nav .dropdown").mouseleave(function(e){
			$( "#main-nav .dropdown-menu" ).clearQueue().finish();
	  		$(this).removeClass("open"); 
			$(this).find(".dropdown-toggle").attr("aria-expanded",false);
		});
	}
	/********** END NAV DROPDOWN HOVER**********/


	/********** SECONDARY NAVIGATION **********/
	// open by hover
	$("#side-nav li.has_sublevel").each(function(){
		var a = $(this).find(".collapse-toggle").first();
		$(this).mouseenter(function(e){
			if (a.attr("aria-expanded")=="false") a.click();
		});
	});


	// close by move outside
	$("#side-nav li").mouseleave(function(){
		$( "#side-nav ul" ).clearQueue().finish();
		/*	$(this).removeClass("open"); 
		$(this).find(".dropdown-toggle").attr("aria-expanded",false);*/
	});

	/********** END SECONDARY NAVIGATION **********/


	/********** UPDATE NAVIGATION - OPEN LEFT **********/
	if ($(window).width()>768) {
		var navTopItems = $("#main-nav > li");
		navTopItems.each(function(index){
			if ($(this).hasClass("dropdown") && navTopItems.length-index<3) {

				var navDropdowns = $(this).children(".dropdown-menu");

				navDropdowns.each(function(){
					var $ul = $(this);
					$ul.addClass("open-left");

					$ul.find(".dropdown > .dropdown-menu").each(function(){
						$(this).addClass("open-left");
					});

				});
			}
		});
	}
	/********** END UPDATE NAVIGATION - OPEN LEFT **********/


	/********** SIDEBAR NAV **********/
	/*if ($(".side-nav").length) {
		$(".side-nav .dropdown_menu").each(function(){
			var $dropdown = $(this);
			var $li = $dropdown.parents("li");

			if (!$li.hasClass("active")) {
				$li.mouseenter(function(){
					$dropdown.slideDown(400);
				});

				$li.mouseleave(function(){
					$dropdown.slideUp(400, function(){$dropdown.clearQueue();});
				});
			}

		});
	}*/
	/********** END SIDEBAR NAV **********/


	/********** MODAL WITH SLIDER **********/
	$("[data-modal-slider='true']").each(function(){
		var $slider = $(this);
		var $modal = $slider.parents(".modal");
		$modal.on("shown.bs.modal", function (e) {
			$slider.show().slick('setPosition');
		});
	});
	/********** END MODAL WITH SLIDER **********/
		
});

function clear_str(str) {
var s=str;
	s = s.replace(/[•\t.+]/g, '');
	s = s.replace(/\s{2,}/g, ' ');
	s = s.replace(/\t/g, ' ');
	s = $.trim(s);
	s = s.toString().replace(/(\r\n|\n|\r)/g,"");
//	s = s.toString().trim().replace(/(\r\n|\n|\r)/g,"");
return s;
}


$.fn.redraw = function(){
	var obj = $(this);
	obj.hide(0, function(){
		obj.show();		
	});
};


$.fn.clearForm = function() {
	return this.each(function() {
		var type = this.type, tag = this.tagName.toLowerCase();
		if (tag == 'form') 
			return $(':input',this).clearForm();
		if (type == 'text' || type == 'password' || type == 'email' || tag == 'textarea') 
			this.value = '';
		else if (type == 'checkbox' || type == 'radio')
			this.checked = false;
		else if (tag == 'select')
			this.selectedIndex = 0;
	});
};

//Usage $.QueryString["param"]
(function($) {
    $.QueryString = (function(a) {
        if (a == "") return {};
        var b = {};
        for (var i = 0; i < a.length; ++i)
        {
            var p=a[i].split('=');
            if (p.length != 2) continue;
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
        }
        return b;
    })(window.location.search.substr(1).split('&'))
})(jQuery);


function GoToBlockDetails(obj){
	var btn = obj.find(".btn");
	window.location.href = btn.attr("href");
}


function GoToBlockPopup(obj){
	var btn = obj.find(".btn");
	btn.click();
}

function isTouchDevice(){
    return true == ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch);
}

