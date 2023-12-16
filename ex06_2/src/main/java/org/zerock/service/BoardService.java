package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.Favorite;
import org.zerock.domain.InfoVO;
import org.zerock.domain.MemberVO;

public interface BoardService {

	public void register(BoardVO board);

	public BoardVO get(Long bno);

	public boolean modify(BoardVO board);

	public boolean remove(Long bno);

	// public List<BoardVO> getList();

	public List<BoardVO> getList(Criteria cri);

	//추가
	public int getTotal(Criteria cri);
	
	public int getTotalByInfoid(Long infoid);
	public int getTotalScoreByInfoid(Long infoid);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
	public void removeAttach(Long bno);

	public InfoVO getInfoById(Long id);
	public InfoVO getInfoByTitle(String title);

	public List<InfoVO> getAllInfo();
	
	public MemberVO getMemberById(String userid);
	
	public void favorite_in(Long infoid, String userid);
	public void favorite_out(Long infoid, String userid);
	
	public Favorite getFavoriteByIdUserid(Long infoid, String userid);
}
