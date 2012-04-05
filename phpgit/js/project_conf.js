$(function(){
        $("input[name=name]").blur(function(){
                var _v = $(this).val().replace(/\.git$/i, "");
                $("input[name=website]").val("http://etao.ued.net/" + _v);
                $("input[name=cloneurl]").val("http://ued.etao.net/git/" + _v + ".git");
                $("input[name=pushurl]").val("git@ued.etao.net:" + _v + ".git");
        });
});

