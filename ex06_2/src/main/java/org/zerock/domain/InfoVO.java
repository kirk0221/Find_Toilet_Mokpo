package org.zerock.domain;

import java.util.Date;
import lombok.Data;

@Data
public class InfoVO {

	private Long id;
	private String title;
	private Double lat;
	private Double lng;
	private String address;
	private Date updateDate;
}
