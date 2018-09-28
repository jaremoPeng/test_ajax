package com.jaremo.test_ajax.mapper;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface AjaxMapper {

    @Select("select * from book")
    public List<Map<String,Object>> findAllBook();
}
