<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<hr color ="yellow">
<pre>
프로토콜  IP(변동)  포트(변동)  고정
http://localhost : 8080 / myHome /
</pre>

<hr color ="red">
<!-- 상대 경로 -->
<pre>
상대 경로 : 내가 현재 위치한 폴더를 기준으로 산정한 경로

./			현재 폴더
../			상위 폴더
폴더명/			하위 폴더

장점 : 간결한주소와 편리한 사용법
단점 : 템플릿 페이지(인클루드 된 페이지)에서는 될때도 안될때도 있다.
</pre>
<hr color ="blue">
<!-- 절대 경로 -->
<pre>
절대 경로 : WebContent 부터 산정한 전체 경로
절대 경로 산출 방법 : <%=request.getContextPath() %>

장점 : 늘 한결같은 경로 (오류 가능성 0%)
단점 : 귀찮고 길다.
</pre>