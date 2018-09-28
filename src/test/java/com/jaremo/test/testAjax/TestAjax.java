package com.jaremo.test.testAjax;

import com.google.gson.Gson;
import com.jaremo.test_ajax.domain.User;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestAjax {
    Map<String,Object> maps = new HashMap<>();
    List<User> userList = new ArrayList<>();

    @Before
    public void initMap(){
        maps.put("usejson","json的使用");
        User user = new User();
        user.setUsername("xiaoming");
        user.setPassword("123456");
        maps.put("user",user);

        User[] users = new User[3];
        User user1 = new User();
        user1.setUsername("xiaom");
        user1.setPassword("1234");
        User user2 = new User();
        user2.setUsername("xiaing");
        user2.setPassword("1256");
        User user3 = new User();
        user3.setUsername("xing");
        user3.setPassword("2345");
        users[0]=user1;
        users[1]=user2;
        users[2]=user3;

        userList.add(user1);
        userList.add(user2);
        userList.add(user3);

        maps.put("users",users);
    }

    @Test
    public void case1(){
        Gson gson = new Gson();
        String strJson = gson.toJson(maps);
        String listStrJson = gson.toJson(userList);



        System.out.println(listStrJson);
    }
}
