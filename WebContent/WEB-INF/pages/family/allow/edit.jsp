<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/family/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/family/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>


<script>
var leader_name_arr = '${leaderList.name}'.split('|');
var leader_chmod_arr = '${leaderList.chmod}'.split('|');
var leader_idx_arr = '${leaderList.idx}'.split('|');
var line_cnt = 1;
var ref_cnt = 1;
var detail_cnt = 1;
$(document).ready(function(){	
	getList();
	getAttach();
	$('.attach_div').hide();
})

function chk_line(way,val)
{
	var idx = $(val).val();
	 $('.line').remove('.'+way+'_line_'+idx);
}

function attach_doc()
{
    $('.attach_div').show();
}

function close_div()
{
	$('.attach_div').hide();
}


//결재자 추가
function add_approval()
{
	var inner = '';
		inner += '<div id="line_'+line_cnt+'" class="approval_div" style="display:inline-block;vertical-align:top;">';	
		inner += '	<select class="approval_class line" id="approval_select_'+line_cnt+'" name="approval_line" onchange="chk_line(\'ref\',this)">';
		inner += '		<option></option>';
	
    for (var i = 0; i < leader_name_arr.length-1; i++) 
    {
    	var chker=false;
        $('.ref_class').each(function()
        { 
            var appro_chk = $(this).val();
        	if (appro_chk==leader_idx_arr[i]) 
        	{
        		chker=true;
    		}
        })
    	
        $('.approval_class').each(function()
        {
            var appro_chk = $(this).val();
        	if (appro_chk==leader_idx_arr[i]) 
        	{
        		chker=true;
    		}
        })
        
        if (chker==false && "${getMyInfo.idx}" != leader_idx_arr[i]) //선택하지 않았고 라인에 내가 없다면
        {
        	inner += '<option class="approval_line_'+leader_idx_arr[i]+'" value='+leader_idx_arr[i]+'>'+leader_name_arr[i]+'</option>'
		}
	}
    
    inner += '	</select>';
    inner += '	<input type="button" id="approval_btn_'+line_cnt+'" value="-삭제" class="btn-del" onclick="del_line('+line_cnt+')">';
	inner += '</div>';
    $("#approval_area").append(inner);
    line_cnt ++;
	
}

//참조자 추가
function add_ref()
{
	var inner ='';
		inner = '<div id="line_'+line_cnt+'" style="display:inline-block;vertical-align:top;">';	
		inner += '	<select class="ref_class line" id="ref_select_'+line_cnt+'" name="ref_line" onchange="chk_line(\'approval\',this)">';
		inner += '		<option></option>';
		
    for (var i = 0; i < leader_name_arr.length-1; i++) 
    {
    	var chker=false;
        $('.ref_class').each(function()
        { 
            var appro_chk = $(this).val();
        	if (appro_chk==leader_idx_arr[i])
			{
        		chker=true;
    		}
        })
        
        $('.approval_class').each(function()
        { 
            var appro_chk = $(this).val();
        	if (appro_chk==leader_idx_arr[i]) 
        	{
        		chker=true;
    		}
        })
        
        if (chker==false && "${getMyInfo.idx}" != leader_idx_arr[i]) //선택하지 않았고 라인에 내가 없다면
        {	
        	inner += '<option class="ref_line_'+leader_idx_arr[i]+'" value='+leader_idx_arr[i]+'>'+leader_name_arr[i]+'</option>'
		}
	}	
	
    inner += '	</select>';
    inner += '	<input type="button" id="ref_btn_'+line_cnt+'" value="-삭제" class="btn-del" onclick="del_line('+line_cnt+')">';
	inner += '</div>';
    $("#ref_area").append(inner);
    line_cnt ++;
}

//결재,참조자 삭제
function del_line(idx)
{
	$("#line_"+idx).remove();
}

function add_jicul_detail()
{
	var inner = "";
	inner += '<div id="detail_'+detail_cnt+'">';
	inner += '	내용 : <input type="text" id="detail_cont_'+detail_cnt+'" name="detail_cont">';
	inner += '	금액 : <input type="text" id="detail_pay_'+detail_cnt+'" name="detail_pay">';
	inner += '	<label for="detail_receipt_'+detail_cnt+'">파일첨부</label>';
	inner += '	<input id="detail_receipt_nm_'+detail_cnt+'" class="upload-name" name="detail_receipt_nm" value="" readonly="readonly">';
	inner += '	<input type="file" id="detail_receipt_'+detail_cnt+'" class="detail_receipt" name="detail_receipt" onchange="checkSize(this,'+detail_cnt+')">';
   	inner += '	<input type="button" value="-삭제" class="btn-del" onclick="del_detail('+detail_cnt+')">';
	inner += '	<br>';
	inner += '</div>';
	$("#jicul_detail").append(inner);
	detail_cnt ++;
}

function add_guntae_detail()
{
	var inner = "";
	inner += '<div id="detail_'+detail_cnt+'">';
	inner += '	<label for="detail_receipt_'+detail_cnt+'">파일첨부</label>';
	inner += '	<input id="detail_receipt_nm_'+detail_cnt+'" class="upload-name" name="detail_receipt_nm" value="" readonly="readonly">';
	inner += '	<input type="file" id="detail_receipt_'+detail_cnt+'" class="detail_receipt" name="detail_receipt" onchange="checkSize(this,'+detail_cnt+')">';
	inner += '	<input type="button" value="-삭제" class="btn-del" onclick="del_detail('+detail_cnt+')">';
	inner += '	<br>';
	inner += '</div>';
	$("#guntae_detail").append(inner);
	detail_cnt ++;
}

function add_rr_detail()
{
	var inner = "";
	inner += '<div id="detail_'+detail_cnt+'">';
	inner += '	내용 : <input type="text" id="detail_cont_'+detail_cnt+'" name="detail_cont">';
	inner += '	금액 : <input type="text" id="detail_pay_'+detail_cnt+'" name="detail_pay">';
	inner += '	<label for="detail_receipt_'+detail_cnt+'">파일첨부</label>';
	inner += '	<input id="detail_receipt_nm_'+detail_cnt+'" class="upload-name" name="detail_receipt_nm" value="" readonly="readonly">';
	inner += '	<input type="file" id="detail_receipt_'+detail_cnt+'" class="detail_receipt" name="detail_receipt" onchange="checkSize(this,'+detail_cnt+')">';
   	inner += '	<input type="button" value="-삭제" class="btn-del" onclick="del_detail('+detail_cnt+')">';
	inner += '	<br>';
	inner += '</div>';
	$("#rr_detail").append(inner);
	detail_cnt ++;
}

function del_detail(idx)
{
	$("#detail_"+idx).remove();
}

/*
function attach_delete(idx)
{
	$(idx).parent('li').remove();
}
*/

function add_attach(idx)
{
	$("#attach_ul").append('<li id='+idx+' name="attach_idx">'+idx+'<input type="button" value="삭제" onclick="delAttach(\''+idx+'\');"></li>');
	$("."+idx).hide();
	$(".attach_div").hide();
}

function delAttach(idx){
	$("."+idx).show();
	$('#'+idx).remove();
}

function getLine(idx)
{
	var myline ="";
	if (idx=="1") 
	{
		myline = "${getMyInfo.line_storage_1}".split('|');
	}
	else if(idx=="2")
	{
		myline = "${getMyInfo.line_storage_2}".split('|');
	}
	else
	{
		myline = "${getMyInfo.line_storage_3}".split('|');
	}
	
	if (nullChk(myline)=="") //저장값이 없다면.
	{	
		alert('저장된 값이 없습니다.');
		return;
	}
	$('.approval_div').empty(); //결재라인 초기화
	
	for (var i = 0; i < myline.length-1; i++) 
	{
		add_approval();
		$('.approval_class').last().val(myline[i]);
	}
}

function getList()
{
	$.ajax({
		type : "POST", 
		url : "./${doc_nm}?idx=${idx}&doc_idx=${doc_idx}&doc_type=${doc_type}",
		dataType : "text",
		async : false,
		
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var inner="";
			
			$('#allow').html(data);			
			
			inner +='<tr>';
			inner +='	<th>첨부문서</th>';
			inner +='	<td id="attach_area">';
			inner +='		<input type="button" value="추가"  onclick="attach_doc()">';
			inner +='		<ul id="attach_ul">';
			inner +='		</ul>';
			inner +='	</td>';
			inner +='</tr>';
			
			inner +='<tr>';
			inner +='	<th>결재라인</th>';
			inner +='	<td id="approval_area"><input type="button" value="추가"  onclick="add_approval()"></td>';
			inner +='</tr>';
			inner +='<tr>';
			inner +='	<th>참조라인</th>';
			inner +='	<td id="ref_area"><input type="button" value="추가"  onclick="add_ref()"></td>';
			inner +='</tr>';
			
			$('.board-lay').prepend(inner);	
			dateInit(); //date-picker재활성화
		}
	});
}

function getAttach()
{
	$.ajax({
		type : "POST", 
		url : "./getAttachList",
		dataType : "text",
		async : false,
		data : 
		{
			idx : "${idx}",
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			
			
			var result = JSON.parse(data);
			var inner ="";
				inner +='<tr>';
				inner +='	<td>No.</td>';
				inner +='	<td>문서번호</td>';
				inner +='	<td>결재일</td>';
				inner +='	<td>종류</td>';
				inner +='	<td></td>';
				inner +='</tr>';
				
			if (result.attachList.length > 0)
			{
				for (var i = 0; i < result.attachList.length; i++) 
				{
					inner +='<tr class="'+result.attachList[i].doc_type+'-'+result.attachList[i].doc_idx+'-'+result.attachList[i].idx+'">';
					inner +='	<td class="Number">'+(i+1)+'</td>';
					inner +='	<td class="Payment">'+result.attachList[i].doc_type+'-'+result.attachList[i].doc_idx+'-'+result.attachList[i].idx+'</td>';
					inner +='	<td class="Confirmdate">'+result.attachList[i].final_date+'</td>';
					inner +='	<td class="attach_title">'+result.attachList[i].doc_nm+'</td>';
					inner +='	<td class="SelBtn"> <input type="button" value="선택" onclick="add_attach(\''+result.attachList[i].doc_type+'-'+result.attachList[i].doc_idx+'-'+result.attachList[i].idx+'\')"> </td>';
					inner +='</tr>';
				}
			}
			else
			{
				inner +='<tr>';
				inner +='	<td colspan="5">결재된 서류가 없습니다.</td>';
				inner +='</tr>';
			}
			$('#attach_area').html(inner);
		
		}
	});
}
</script>
<div class="attach_div">
		<div class="closeBtn">
			<input type="button" onclick="close_div();" value="닫기" class="attachClose">
		</div>
		<div class="root_tableWrap">
				<div class="tableWrap">
			<div class="tableBox">
				<table border="1" class="table" id="attach_area">

				</table>
			</div><!-- class="tableBox" -->
		</div><!-- class="tableWrap" -->
	</div>
</div><!-- class="attach_div" -->



<div id="container" class="allow-wrap">
	<div class="musign-grid">	
    	<div class="allow-table">
    		
    		    <input type="button" value="라인1" onclick="getLine('1')" >
    		    <input type="button" value="라인2" onclick="getLine('2')" >
    		    <input type="button" value="라인3" onclick="getLine('3')" >
    		    
    		<form id="fncForm" name="fncForm" method="post" enctype="multipart/form-data">
	    		<div id="allow">
	
	    		</div>
    		</form>
    
    		<div class="btn-wrap ali-right">
   				<input class="btn_black01 btn" type="button"  value="수정" onclick="fncSubmit('E')">
        	</div>
    		
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/pages/family/common/footer.jsp"/>