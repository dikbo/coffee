var test = new Vue({
    el: '#test',
    mounted: function() {
        $('#intro').show();
        $('#main1').hide();
        $('#main2').hide();
        $('#main3').hide();
        $('#main4').hide();
        $('#result').hide();
    },
    
    methods: {
        start: function() {
            $('#intro').hide();
            $('#main1').show();
            $('#main2').hide();
            $('#main3').hide();
            $('#main4').hide();
            $('#result').hide();
        },
        prev: function() {
            alert('첫 문항 입니다');
        },
        retr: function() {
            $('#intro').show();
	        $('#main1').hide();
	        $('#main2').hide();
	        $('#main3').hide();
	        $('#main4').hide();
	        $('#result').hide();
        },
        next: function() {
            $('#intro').hide();
            $('#main1').hide();
            $('#main2').show();
            $('#main3').hide();
            $('#main4').hide();
            $('#result').hide();
            var value = $('input[name="categorycode_ref"]:checked').val();

			if(value == '100') {
				$('#cate100').show();
				$('#cate200').hide();
			}else if(value == '200') {
				$('#cate100').hide();
				$('#cate200').show(); 
			}
        },
        next2: function() {
            $('#intro').hide();
            $('#main1').hide();
            $('#main2').hide();
            $('#main3').show();
            $('#main4').hide();
            $('#result').hide();
        },
        next3: function() {
            $('#intro').hide();
            $('#main1').hide();
            $('#main2').hide();
            $('#main3').hide();
            $('#main4').show();
            $('#result').hide();
        },
        next4: function() {
            $('#intro').hide();
            $('#main1').hide();
	        $('#main2').hide();
	        $('#main3').hide();
	        $('#main4').hide();
            $('#result').show();
        }
    }
});