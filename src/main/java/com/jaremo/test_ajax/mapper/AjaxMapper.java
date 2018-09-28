package com.jaremo.test_ajax.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface AjaxMapper {

    @Select("select * from book")
    public List<Map<String,Object>> findAllBook();

    @Delete("delete from book where bid=#{bid}")
    public void removeBookByBid(@Param("bid") Integer bid);
}
