package tk.mybatis.web.mapper;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import tk.mybatis.web.model.SysDict;

public interface DictMapper {
	
	SysDict selectByPrimaryKey(Long id);
	
	List<SysDict> selectBySysDict(SysDict sysDict, RowBounds rowBounds);

}
