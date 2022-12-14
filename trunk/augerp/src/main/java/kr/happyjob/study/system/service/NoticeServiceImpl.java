package kr.happyjob.study.system.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.NoticeModel;


@Service
public class NoticeServiceImpl implements NoticeService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticeimage}")
	private String noticePath;
	
	@Autowired
	NoticeDao noticeDao;
	
	
	public List<NoticeModel> listNoticeModel(Map<String, Object> paramMap) throws Exception {
		
		List<NoticeModel> listNoticeModel = noticeDao.listNoticeModel(paramMap);
		
		return listNoticeModel;
	}
	
	public int totNoticeModel(Map<String, Object> paramMap) throws Exception {
		
		int totNoticeModel = noticeDao.totNoticeModel(paramMap);
		
		return totNoticeModel;
	}	
	
    public NoticeModel selectnotice(Map<String, Object> paramMap) throws Exception {
		
		NoticeModel NoticeModel = noticeDao.selectnotice(paramMap);
		
		return NoticeModel;
	}
	
    
    public int updatenoticereadcnt(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.updatenoticereadcnt(paramMap);
	}
    
    public int insertnotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.insertnotice(paramMap);
	}
    
    public int updatenotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.updatenotice(paramMap);
	}
    
    public int deletenotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.deletenotice(paramMap);
	}
    
    public void insertnoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
				
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		String logicalpath = "http://localhost/serverfile" + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);		
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
		
		paramMap.put("fileinf", fileInfo);
		
		if(fileInfo.get("file_nm") == null) {
			paramMap.put("fileyn", "N");
		} else {
			paramMap.put("fileyn", "Y");
			noticeDao.insertnoticefile(paramMap);
		}
		
		//logger.info("   - insertnoticefile paramMap : " + paramMap);
		
		noticeDao.insertnotice(paramMap);
		
    	
		return;
	}
    
    public void updatenoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		// 수정  기존에 등록된 파일정보 삭제
		// 실제 파일 삭제
		// tb_announce  att_no null 값 셋팅
		// tb_attachment att_no 삭제
		NoticeModel noticeModel = noticeDao.selectnotice(paramMap);
		
		if(noticeModel.getAtt_ori()!= null) {
			// 파일 삭제
			String Fullpath = noticeModel.getAtt_mul();
			File orgfile = new File(Fullpath);
			orgfile.delete();
			
			// tb_attachment att_no 삭제
			noticeDao.noticefiledelete(paramMap);
			
			// tb_announce  att_no null 값 셋팅
			noticeDao.notefileinit(paramMap);				
		}
		
		
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		String logicalpath = "http://localhost/serverfile" + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);		
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
		
		paramMap.put("fileinf", fileInfo);
		
		if(fileInfo.get("file_nm") == null) {
			paramMap.put("fileyn", "N");
		} else {
			paramMap.put("fileyn", "Y");
			noticeDao.insertnoticefile(paramMap);
		}
		
		//logger.info("   - insertnoticefile paramMap : " + paramMap);
		
		noticeDao.updatefilenotice(paramMap);
		    	
    	
    	
		return;
	}
    
    public void deletenoticefile(Map<String, Object> paramMap) throws Exception {
		
    	// 첨부된 파일이 있으면
    	// 실제 파일 삭제
    	// tb_attachment att_no 삭제
        NoticeModel noticeModel = noticeDao.selectnotice(paramMap);
		
		if(noticeModel.getAtt_ori()!= null) {
			// 파일 삭제
			String Fullpath = noticeModel.getAtt_mul();
			File orgfile = new File(Fullpath);
			orgfile.delete();
			
			// tb_attachment att_no 삭제
			noticeDao.noticefiledelete(paramMap);						
		}
    	
    	// 공통
    	// tb_announce  att_no 삭제
		noticeDao.deletenotice(paramMap);
    	
		return;
	}    
    
}
