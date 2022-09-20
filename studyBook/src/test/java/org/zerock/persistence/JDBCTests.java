package org.zerock.persistence;

import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;
import static  org.junit.Assert.fail;

import lombok.extern.java.Log;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

    static{
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection(){
        try(Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","scott", "tiger")){
           log.info(con);
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}