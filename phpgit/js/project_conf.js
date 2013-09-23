$(function(){
        $("input[name=name]").blur(function(){
		var v = $(this).val();
                var _v = v.replace(/\.git$/i, "");
		if (-1 == v.indexOf('.git')) {
			$(this).val(v + ".git");
		}
                $("input[name=website]").val("http://demo.etao.net/" + _v);
                $("input[name=cloneurl]").val("http://ued.etao.net/git/" + _v + ".git");
                $("input[name=pushurl]").val("git@ued.etao.net:" + _v + ".git");
        });
});

