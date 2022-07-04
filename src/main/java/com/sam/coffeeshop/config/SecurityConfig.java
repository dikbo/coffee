package com.sam.coffeeshop.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
@EnableWebSecurity //스프링 시큐리티 필터가 스프링 필터체인에 등록
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// TODO Auto-generated method stub
		http.csrf().disable();
		http.authorizeHttpRequests()
		.antMatchers("/**").permitAll() //누구나 접근가능
		.antMatchers("/admin/**").hasRole("ROLE_ADMIN")
		.antMatchers("/member/myPage/**").hasRole("ROLE_MEMBER")
			.and()
		.formLogin() //form 기반 로그인 인증 관련하여 HttpSession이용
		.usernameParameter("member_id")
		.passwordParameter("password")
		.loginPage("/member/loginForm") //지정하고 싶은 로그인페이지
		.loginProcessingUrl("/member/loginProc") 
		.defaultSuccessUrl("/",true)
		//.failureUrl("/member/loginForm") //로그인 실패시
			.and()
		.logout()
		.logoutUrl("/member/logout")
		.logoutSuccessUrl("/member/loginForm")
		.invalidateHttpSession(true);
		
	}
}
