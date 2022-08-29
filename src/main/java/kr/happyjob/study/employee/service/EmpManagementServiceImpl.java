package kr.happyjob.study.employee.service;

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
import kr.happyjob.study.employee.dao.EmpManagementDao;
import kr.happyjob.study.employee.model.Department;
import kr.happyjob.study.employee.model.EmpManagement;
import kr.happyjob.study.system.model.NoticeModel;

@Service
public class EmpManagementServiceImpl implements EmpManagementService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticeimage}")
	private String empManagementPath;

	@Autowired
	EmpManagementDao empManagementDao;	
	
	public List<Department> departmentList() throws Exception {
		
		return empManagementDao.departmentList();
	}

	public List<EmpManagement> listEmpManagementModel(Map<String, Object> paramMap) throws Exception {
		
		List<EmpManagement> listEmpManagementModel = empManagementDao.listEmpManagementModel(paramMap);
		
		return listEmpManagementModel;
	}

	public int totEmpManagementModel(Map<String, Object> paramMap) throws Exception {
		
		return empManagementDao.totEmpManagementModel(paramMap);
	}

	public EmpManagement selectUserRetire(Map<String, Object> paramMap) throws Exception {
		
		return empManagementDao.selectUserRetire(paramMap);
	}

	public int saveUserRetire(Map<String, Object> paramMap) throws Exception {
		
		return empManagementDao.saveUserRetire(paramMap);
	}

	public void insertEmpManagementfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일 처리 하는 부분
		//파일저장
		String itemFilePath = empManagementPath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		String logicalpath = "http://localhost/serverfile" + File.separator + empManagementPath + File.separator + fileInfo.get("file_nm");
		 	
		fileInfo.put("loc_file_loc", logicalpath);		
		paramMap.put("fileinf", fileInfo);
		
		//주민번호 수정
		String Con1 = (String)paramMap.get("Con1");
		String Con2 = (String)paramMap.get("Con2");
		
		String user_con = Con1 + "-" + Con2 ;
		paramMap.put("user_con", user_con);
		
		//휴대전화 수정 
		String tel1 = (String)paramMap.get("tel1");
		String tel2 = (String)paramMap.get("tel2");
		String tel3 = (String)paramMap.get("tel3");
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		paramMap.put("tel", tel);
		
		//연봉 계산
		int salary = Integer.parseInt(((String)paramMap.get("sal_ad")).replaceAll(",", ""));
		EmpManagement emp = new EmpManagement().calculateSalary(salary);
		paramMap.put("sal_bt", emp.getSal_bt());
		paramMap.put("sal_price", emp.getSal_price());
		paramMap.put("sal_kuk", emp.getSal_kuk());
		paramMap.put("sal_kun", emp.getSal_kun());
		paramMap.put("sal_ko", emp.getSal_ko());
		paramMap.put("sal_san", emp.getSal_san());
		paramMap.put("sal_ad", salary);
		
		//회원을 저장하는 부분 
		empManagementDao.insertEmpManagement(paramMap);
		
		//파일 저장하는 부분	
		empManagementDao.insertEmpManagementfile(paramMap);

		//휴가 잔여 테이블 
		empManagementDao.insertDtlVacation(paramMap);
		
		//급여 테이블에 입력하기 
		empManagementDao.insertSalaryTable(paramMap);
		
		//인사이력정보테이블에 입력
		empManagementDao.insertHumanHistory(paramMap);
	}

	public String selectempManagementID() throws Exception {
		
		return empManagementDao.selectempManagementID();
	}

	public EmpManagement selectempManagementInfo(Map<String, Object> paramMap) throws Exception {
		
		return empManagementDao.selectempManagementInfo(paramMap);
	}

	public void updateEmpManagementfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		
		
		
		//주민번호 수정
		String Con1 = (String)paramMap.get("Con1");
		String Con2 = (String)paramMap.get("Con2");
		
		String user_con = Con1 + "-" + Con2 ;
		paramMap.put("user_con", user_con);
		
		//휴대전화 수정 
		String tel1 = (String)paramMap.get("tel1");
		String tel2 = (String)paramMap.get("tel2");
		String tel3 = (String)paramMap.get("tel3");
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		paramMap.put("tel", tel);
		
		//연봉 계산
		
		int salary = Integer.parseInt(((String)paramMap.get("sal_ad")).replaceAll(",", ""));
		int salaryBefore = Integer.parseInt(((String)paramMap.get("salaryBefore")).replaceAll(",", ""));
		EmpManagement emp = new EmpManagement().calculateSalary(salary);
		paramMap.put("sal_bt", emp.getSal_bt());
		paramMap.put("sal_price", emp.getSal_price());
		paramMap.put("sal_kuk", emp.getSal_kuk());
		paramMap.put("sal_kun", emp.getSal_kun());
		paramMap.put("sal_ko", emp.getSal_ko());
		paramMap.put("sal_san", emp.getSal_san());
		paramMap.put("sal_ad", salary);
		
		//사원 업데이트 하기 
		empManagementDao.updateEmpManagementfile(paramMap);
		
		//이전 연봉과 수정한 연봉이 같지 않으면 여기를 타야 한다.
		if(salary != salaryBefore){
			empManagementDao.insertSalaryTable(paramMap);
		}
		
		//이전 부서와 수정 부서가 다르거나 이전 직급과 수정 직급이 다른 경우에 타야 한다.
		String beforeJob = (String)paramMap.get("job_cdBefore");
		String afterJob = (String)paramMap.get("job_cd");
		String beforeDept = (String)paramMap.get("dept_cdBefore");
		String afterDept = (String)paramMap.get("dept_cd");
		if(!beforeJob.equals(afterJob) || !beforeDept.equals(afterDept)){
			empManagementDao.insertHumanHistory(paramMap);
		}
		
	}
}
