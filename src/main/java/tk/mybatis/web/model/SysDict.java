package tk.mybatis.web.model;

import java.io.Serializable;

public class SysDict implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private String name;
	
	private String code;
	
	private String value;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	

}
