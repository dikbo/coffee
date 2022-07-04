<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--  
    Document Title
    =============================================
    -->
    <title>Titan | 원두커피 쇼핑몰</title>
    <!--  
    Favicons
    =============================================
    -->
    <link rel="apple-touch-icon" sizes="57x57" href="/images/favicons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/images/favicons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/images/favicons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/images/favicons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/images/favicons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/images/favicons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/images/favicons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/images/favicons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/images/favicons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="/images/favicons/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/images/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="/images/favicons/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/images/favicons/favicon-16x16.png">
    <link rel="manifest" href="/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/images/favicons/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <!--  
    Stylesheets
    =============================================
    
    -->
    <!-- Default stylesheets-->
    <link href="/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template specific stylesheets-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="/lib/animate.css/animate.css" rel="stylesheet">
    <link href="/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
    <link href="/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
    <!-- Main stylesheet and color file-->
    <link href="/css/style.css" rel="stylesheet">
    <link id="color-scheme" href="/css/colors/default.css" rel="stylesheet">
  </head>
  	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="principal" />
	</sec:authorize>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    <main>
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
          <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#custom-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="/index">Titan</a>
          </div>
          <div class="collapse navbar-collapse" id="custom-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">추천원두</a>
                <ul class="dropdown-menu">
                  <li><a href="/test">원두 취향 테스트 하기</a></li>
                </ul>
              </li>
              
              <li class="dropdown"><a class="dropdown-toggle" href="/board/list" data-toggle="dropdown">상품 카테고리</a>
                <ul class="dropdown-menu">
                  <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">커피 원두</a>
                    <ul class="dropdown-menu">
                      <li><a href="/board/list/cate?cate=101">오리지널</a></li>
                  	  <li><a href="/board/list/cate?cate=102">디카페인</a></li>
                    </ul>
                  </li>
                  <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">콜드브루</a>
                    <ul class="dropdown-menu">
                      <li><a href="/board/list/cate?cate=201">오리지널</a></li>
                  	  <li><a href="/board/list/cate?cate=202">디카페인</a></li>
                    </ul>
                  </li>
                </ul>
              </li>                  
              
              <sec:authorize access="isAnonymous()">
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">로그인</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="/member/loginForm">로그인</a></li>
                  <li><a href="/member/join">회원가입</a></li>
                </ul>
              </li>
              </sec:authorize>
              <sec:authorize access="isAuthenticated()">
              <li class="dropdown"><a class="dropdown-toggle" 
              	href="/member/logout">로그아웃
              	(<sec:authentication property="principal.member.member_id"/>)</a>
              </li>
              <li class="dropdown"><a class="dropdown-toggle" href="/member/myPage" data-toggle="dropdown">마이페이지</a>
              	<ul class="dropdown-menu" role="menu">
              	<li><a href="/member/memberUpdateView">내정보수정</a></li>
                  <li><a href="/board/cartList">장바구니</a></li>
                </ul>
              </li>
              </sec:authorize>
              
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">고객센터</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="/board/qna/qnaBoard">QnA</a></li>
                </ul>
              </li>
              
              <sec:authorize access="hasRole('ROLE_ADMIN')">
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">관리자 페이지</a>
                <ul class="dropdown-menu">
                  <li><a href="/admin/memberManage">회원 관리</a></li>
                  <li><a href="/admin/adminProductList">상품 관리</a></li>
                  <li><a href="/admin/adminOrderList">주문 관리</a></li>
                </ul>
              </li>
              </sec:authorize>
            </ul>
          </div>
        </div>
      </nav>