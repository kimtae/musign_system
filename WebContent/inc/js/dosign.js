

function show_comment(way)
{	
	$('.conmment_div').hide();
	$('.return_div').hide();
	
	if (way=="approve") {	
		$('.conmment_div').show();
		if ($('.conmment_div').hasClass('on')) {
			$('.conmment_div').removeClass('on');
		}else{
	    	$('.conmment_div').addClass('on');
			$('.conmment_div').hide();
		}
	}else{
		$('.return_div').show();
		if ($('.return_div').hasClass('on')) {
			$('.return_div').removeClass('on');
		}else{
	    	$('.return_div').addClass('on');
			$('.return_div').hide();
		}
	}
	
}


function commemt_chk(index,useridx,way)
{	
	start_loading();
	$.ajax({
		type : "POST", 
		url : "/family/dosign/getApprovalLine",
		dataType : "text",
		data : 
		{
			idx : index,
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (result.isSuc =="fail") {
				alert(result.msg);
				location.href="/main";
			}
			if (way=="approve")
			{
				var approval_line = result.data.approval_line.split('|');
				var approval_cont = result.data.approval_content.split('|');
				
				for (var i = 0; i < approval_line.length; i++) {
					if (approval_line[i] == useridx) {
						alert(approval_cont[i]);
						break;
					}
				}
			}
			else
			{
				alert(result.data.return_why);
			}
			end_loading();
		}
	});
}


function approve_chk(idx){
	if(!confirm("승인 하시겠습니까?"))
	{
		return;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./chkApprovalLine",
		dataType : "text",
		data : 
		{
			idx : idx,
			content : $("#comment").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
//			getList();
//			show_comment();
			location.reload();
		}
	});
	
}


function return_chk(idx){
	if(!confirm("반려 하시겠습니까?"))
	{
		return;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./chkReturn",
		dataType : "text",
		data : 
		{
			idx : idx,
			content : $("#return_comment").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
//			getList();
//			show_comment();
			location.reload();
		}
	});
	
}


function final_approve(idx){
	if(!confirm("최종 승인 하시겠습니까?"))
	{
		return;
	}
	start_loading();
	$.ajax({
		type : "POST", 
		url : "./chkFinal",
		dataType : "text",
		data : 
		{
			idx : idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
//			getList();
//			show_comment();
			location.href="/family/dosign/list";
		}
	});
	
}



