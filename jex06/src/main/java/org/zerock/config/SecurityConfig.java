package org.zerock.config;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.zerock.security.CustomLoginSuccessHandler;
import org.zerock.security.CustomUserDetailsService;
import sun.security.util.Password;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Setter(onMethod_ = {@Autowired})
    private DataSource dataSource;

    @Override
    public void configure(HttpSecurity http) throws Exception{
        http.authorizeRequests()
                .antMatchers("/sample/all").permitAll()
                .antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
                .antMatchers("/sample/member").access("hasRole('ROLE_MEMBER')");

        http.formLogin().loginPage("/customLogin").loginProcessingUrl("/login");

        http.logout()
                .logoutUrl("/customLogout")
                .invalidateHttpSession(true)
                .deleteCookies("remember-me", "JSESSION_ID");

        http.rememberMe()
                .key("zerock")
                .tokenRepository(persistentTokenRepository())
                .tokenValiditySeconds(604800);
    }

    @Bean // remember-me 설정
    public PersistentTokenRepository persistentTokenRepository(){
        JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
        repo.setDataSource(dataSource);
        return repo;
    }

    @Bean // CustomLoginSuccessHandler
    public AuthenticationSuccessHandler loginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }

    @Bean // Encoder 암호화
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService customUserService(){
        return new CustomUserDetailsService();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
    }

    /* JDBC 설정
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        log.info("configure JDBC......................");

        String queryUser = "SELECT userid, userpw, enabled FROM tbl_member WHERE userid=?";
        String queryDetails = "SELECT userid, auth FROM tbl_member_auth WHERE userid=?";

        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .passwordEncoder(passwordEncoder())
                .usersByUsernameQuery(queryUser)
                .authoritiesByUsernameQuery(queryDetails);
    }
    */

    /* 클래스에 로그인 정보 저장
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        log.info("configure........................................");
        auth.inMemoryAuthentication().withUser("admin").password("{noop}admin").roles("ADMIN");
        // member -> $2a$10$TNUkK9UaCehUelyYv7yDvOWG5AnUjXFqjLL/Eu14Yfek2c38RgEZW
        auth.inMemoryAuthentication().withUser("member").password("$2a$10$TNUkK9UaCehUelyYv7yDvOWG5AnUjXFqjLL/Eu14Yfek2c38RgEZW").roles("MEMBER");
    }
    */

}