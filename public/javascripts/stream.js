var LifeStream = {
	
	init : function()
	{
		LifeStream.infiniteScroll();
	},
	
	infiniteScroll : function()
	{
		$(window).scroll(function(){
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				LifeStream.showHiddenItems();
				LifeStream.getItems();
			}
		});
	},
	
	getItems : function()
	{
		var last_item_id = $('#lifestream li:last').attr('id');
		var offset = parseInt(last_item_id.replace('item-', '')) + 1;
		
		$.get('/items.js', { offset : offset }, function(data){
			$('#lifestream').append(data);
		});
	},
	
	showHiddenItems : function()
	{
		$('#lifestream .js_hide').removeClass('js_hide');
	}
};

$(document).ready(function() { LifeStream.init(); });