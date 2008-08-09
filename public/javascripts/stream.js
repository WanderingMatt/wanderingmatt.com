var LifeStream = {
	
	init : function()
	{
		LifeStream.getItems();
		
		// $(window).scroll(function(){
		// 	if ($(window).scrollTop() == $(document).height() - $(window).height()) {
		// 		LifeStream.showHiddenItems();
		// 		LifeStream.getItems();
		// 	}
		// });
	},
	
	getItems : function()
	{
		// last_item = $('#lifestream:last');
		
		$.get('/items.js', { offset : 10 }, function(data){
			$('#lifestream').append(data);
		});
	},
	
	showHiddenItems : function()
	{
		$('#lifestream .js_hide').removeClass('js_hide');
	}
};

$(document).ready(function() { LifeStream.init(); });