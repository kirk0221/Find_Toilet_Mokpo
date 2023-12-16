package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.Favorite;
import org.zerock.domain.InfoVO;
import org.zerock.domain.MemberVO;

public interface BoardMapper {

	public List<BoardVO> getList();

	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void addInfo(InfoVO info);

	public void insert(BoardVO board);

	public Integer insertSelectKey(BoardVO board);

	public BoardVO read(Long bno);

	public int delete(Long bno);

	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);
	public int getTotalCountByInfoid(@Param("infoid") Long infoid);
	
	public int getTotalScoreByInfoid(@Param("infoid") Long infoid);

	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	public void updateInfoscore(@Param("infoscore") Double infoscore, @Param("infoid") Long infoid);
	
	public List<BoardAttachVO> findByBno(Long bno);

	public InfoVO getInfoById(Long id);
	public InfoVO getInfoByTitle(String title);

	public List<InfoVO> getAllInfo();
	
	public MemberVO getMemberById(String userid);
	
	public void favorite_in(@Param("infoid") Long infoid, @Param("userid") String userid);
	public void favorite_out(@Param("infoid") Long infoid, @Param("userid") String userid);
	
	public Favorite getfavoriteByIdUserid(@Param("infoid") Long info_id, @Param("userid") String userid);

}
 