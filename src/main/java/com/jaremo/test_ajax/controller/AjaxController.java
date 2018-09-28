package com.jaremo.test_ajax.controller;

import com.google.gson.Gson;
import com.jaremo.test_ajax.mapper.AjaxMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class AjaxController {

    @Autowired
    private AjaxMapper ajaxMapper;

    @RequestMapping("/getjson")
    public String getDataJson(HttpServletResponse response){
        List<Map<String,Object>> bookList = ajaxMapper.findAllBook();
        Gson gson = new Gson();
        String resultJson = gson.toJson(bookList);
        try {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().print(resultJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
