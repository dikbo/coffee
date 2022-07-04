<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

      <section class="home-section home-full-height" id="home">
        <div class="hero-slider">
          <ul class="slides">
            <li class="bg-dark-30 restaurant-page-header bg-dark" style="background-image:url(&quot;images/coffeeshop/main1.jpg&quot;);">
              <div class="titan-caption">
                <div class="caption-content">
                  <div class="font-alt mb-30 titan-title-size-1">행복한 커피 문화를 만들어갑니다</div>
                  <div class="font-alt mb-40 titan-title-size-4">Make Every Coffee Day, with Titan </div><a class="section-scroll btn btn-border-w btn-round" href="/test">Discover Your Taste!</a>
                </div>
              </div>
            </li>
            <li class="bg-dark-30 restaurant-page-header bg-dark" style="background-image:url(&quot;images/coffeeshop/main2.jpg&quot;);">
              <div class="titan-caption">
                <div class="caption-content">
                	<div class="font-alt mb-30 titan-title-size-1">공정하고 깨끗한 커피</div>
                  <div class="font-alt mb-30 titan-title-size-3">Fresh Beans, Clean Process</div>
                  <div class="font-alt mb-30 titan-title-size-1">현지 커피 농장에서 직수입한 Titan의 커피는<br>자체 생산 라인에서 가공되어 뛰어난 맛과 향, 최상의 품질을 보장합니다.</div><a class="btn btn-border-w btn-round" href="/board/list">Look Around Product</a>
                </div>
              </div>
            </li>
            <li class="bg-dark-30 restaurant-page-header bg-dark" style="background-image:url(&quot;images/coffeeshop/main3.jpg&quot;);">
              <div class="titan-caption">
                <div class="caption-content">
                  <div class="font-alt mb-30 titan-title-size-1">Titan의 회원이 되어 행복한 커피 문화를 즐겨보세요</div>
                  <div class="font-alt mb-40 titan-title-size-3">Be Our Family</div><a class="section-scroll btn btn-border-w btn-round" href="/member/join">Join Us</a>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </section>
      <div class="main">
      	<section class="module" id="specialities">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Take a look at</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt">New Product</h2>
              </div>
            </div>
            
            <div class="row multi-columns-row">
            <c:forEach items="${plist}" var="p">
              <div class="col-sm-6 col-md-3 col-lg-3">
                <div class="shop-item">
				<input type="hidden" id="product_id" value="${p.product_id}">
					<div class="shop-item-image">
					<img src="/resources/productImg/${p.product_img}" alt=""/>
                  	</div>
                  	<h2 class="shop-item-title font-alt"><a href="/board/productDetail?product_id=${p.product_id}" >${p.product_name}</a></h2>
				</div>
                <!-- <div class="content-box">
                  <div class="content-box-image"><img src="/images/restaurant/kabab.jpg" alt=""/></div>
                  <h3 class="content-box-title font-serif">Single Blend</h3>Careful attention to detail and clean, well structured code ensures a smooth user experience for all your visitors.
                </div> -->
              </div>
            </c:forEach>
            </div>
          </div>
        </section>
        <hr class="divider-w">
        <section class="module" id="services">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">For your comfort</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt">Our Services</h2>
              </div>
            </div>
            <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-3 col-lg-3">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-clock"></span></div>
                  <h3 class="features-title font-alt">연중무휴</h3>본사 직영으로 운영되는 매장은 세심하고 깨끗하게 관리되어 최상의 환경에서 만들어진 커피 원두를 제공합니다.
                </div>
              </div>
              <div class="col-sm-6 col-md-3 col-lg-3">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-streetsign"></span></div>
                  <h3 class="features-title font-alt">주차 안내</h3>카페 고객 전용 주차장이 있으며 매장 내 이용 시 2시간 무료입니다. 
                </div>
              </div>
              <div class="col-sm-6 col-md-3 col-lg-3">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-map"></span></div>
                  <h3 class="features-title font-alt">매장 안내</h3>부산광역시 부산진구 중앙대로708 부산파이낸스센터 빌딩 4~5층 운영시간 : 오전 9:00 ~ 오후 5:30
                </div>
              </div>
              <div class="col-sm-6 col-md-3 col-lg-3">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-heart"></span></div>
                  <h3 class="features-title font-alt">품질보증</h3>본 사이트는 Titan 본사 공식 판매처 입니다. 사이트 내 판매되는 모든 제품은 본사에서 출고되는 정품임을 보증합니다.
                </div>
              </div>
            </div>
          </div>
        </section>        
        <section class="module module-video bg-dark-30" data-background="/images/restaurant/coffee_bg.png">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h2 class="module-title font-alt mb-0">The Best choice For Your Coffee. Enjoy Your Everyday!</h2>
              </div>
            </div>
          </div>
          <div class="video-player" data-property="{videoURL:'https://www.youtube.com/watch?v=i_XV7YCRzKo', containment:'.module-video', startAt:3, mute:true, autoPlay:true, loop:true, opacity:1, showControls:false, showYTLogo:false, vol:25}"></div>
        </section>
            

<%@ include file="include/footer.jsp" %>