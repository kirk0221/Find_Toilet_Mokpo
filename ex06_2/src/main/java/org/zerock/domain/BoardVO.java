package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Long score;
	private Date regdate;
	private Date updateDate;
	private Long infoid;
	
	private int replyCnt;

	private List<BoardAttachVO> attachList;
}
