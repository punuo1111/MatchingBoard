<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.adminLoginContainer {
	margin-top: 30vh;
}
</style>

<script type="text/javascript">
$(function(){
	$('#aloginf').submit(function(e){
		//alert($('#admin_pw').val());
		//e.preventDefault();
		if (!$('#admin_pw').val()) {
			alert('관리자 비밀번호를 입력하세요');
			$('#admin_pw').focus();
			return false;
		}
	});
});
</script>

<div class="adminLoginContainer text-center">
	<form name="aloginf" id="aloginf" action="./adminLogin" method="post">
		<input type="password" name="admin_pw" id="admin_pw" placeholder="Password"> <br><br>
		<button type="submit"id="btnAdminLogin" class="btn btn-primary">관리자 로그인</button>
	</form>
</div>