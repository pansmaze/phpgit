/*
 * GitPHP javascript project search
 *
 * Live search of project list
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Javascript
 */

var oldSearchValue = '';
var searchTimeout = null;

function runSearch() {
	var search = $('input.projectSearchBox').val().toLowerCase();
	var category = $('ul.guide_bar > li.active').attr('data-cate');
	oldSearchValue = search;
	clearTimeout(searchTimeout);
	searchTimeout = null;
	
	if (search.length == 0) {
		$('a.clearSearch').hide();
	} else {
		$('a.clearSearch').show();
	}

	var visibleCats = [];

	var hasmatch = false;
	var search_set = ('' == category) ? $(".project") : $(".project[data-cate=" + category + "]");// search by category
	search_set.each(function(){
		var target_str = $(this).attr("data-cate")+$(this).find(".pname").text()+$(this).find(".owner").text()+$(this).find(".description").text();
		var match = target_str.toLowerCase().indexOf(search) != -1;
		if(match){
			$(this).show();
		}else{
			$(this).hide();
		}
		hasmatch = hasmatch||match;	
	});

	var msgDiv = $('div.message');
	if (hasmatch) {
		msgDiv.hide();
	} else {
		if (msgDiv.length == 0) {
			msgDiv = jQuery(document.createElement('div'));
			msgDiv.addClass('message');
			msgDiv.appendTo($('.project_list'));
		}

		var msg = GITPHP_RES_NO_MATCHES_FOUND.replace(new RegExp('%1'), $('input.projectSearchBox').val());
		msgDiv.text(msg);

		msgDiv.show();
		$('.project').hide();
	}

	$('img.searchSpinner').hide();
};

function initProjectSearch() {
	$('#projectSearchForm').keypress(function(e) {
		if (e.which == 13) {
			return false;
		}
	});

	var rows = $('.project');
	if (rows.length == 0) {
		// No projects, just stop
		return;
	}

	$('a.clearSearch').click(function() {
		$('img.searchSpinner').show();
		$('input.projectSearchBox').val('');
		oldSearchValue = '';
		runSearch();
		return false;
	});

	var typeEvent = function() {
		if ($('input.projectSearchBox').val() != oldSearchValue) {
			$('img.searchSpinner').show();
			if (searchTimeout != null) {
				clearTimeout(searchTimeout);
			}
			setTimeout("runSearch()", 500);
		}
	};

	$('input.projectSearchBox').keyup(typeEvent).bind('input paste', typeEvent);
};

$(document).ready(function() {
	initProjectSearch();
});
