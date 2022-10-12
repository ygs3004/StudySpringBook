package org.zerock.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@EnableWebMvc
@ComponentScan(basePackages = {"org.zerock.controller"}) // , "org.zerock.exception"
@EnableGlobalAuthentication // (prePostEnabled=true, securedEnabled=true) 왜인지 안댐; 버젼?
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry resgistry){

        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        resgistry.viewResolver(bean);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
/*
    @Bean(name="multipartResolver")
    public CommonsMultipartResolver getResolver() throws IOException {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();

        //10MB
        resolver.setMaxUploadSize(1024*1024*10);

        //2MB
        resolver.setMaxUploadSizePerFile(1024*1024*2);

        //1MB
        resolver.setMaxInMemorySize(1024*1024);

        //temp upload
        resolver.setUploadTempDir(new FileSystemResource("C:\\upload\\tml"));

        resolver.setDefaultEncoding("UTF-8");

        return resolver;
    }
*/

    @Bean
    public MultipartResolver multipartResolver(){
        StandardServletMultipartResolver resolver = new StandardServletMultipartResolver();

        return resolver;
    }
}