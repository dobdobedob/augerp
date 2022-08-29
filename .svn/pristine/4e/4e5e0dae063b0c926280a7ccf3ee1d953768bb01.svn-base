package kr.happyjob.study.business.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.OeManagementDao;
import kr.happyjob.study.business.model.OeManagementDtlListModel;
import kr.happyjob.study.business.model.OeManagementDtlModel;
import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.business.model.OeModalModel;


@Service
public class OeManagementServiceImpl implements OeManagementService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	OeManagementDao oeManagementDao;

	/*수주관리 리스트*/
	@Override
	public List<OeManagementModel> listOeManagement(Map<String, Object> paramMap) throws Exception {
		
		List<OeManagementModel> listOeManagement = oeManagementDao.listOeManagement(paramMap); 
		
		
		int supply_price = 0; 
		int tax_amount = 0; 
		
		for(int i=0;i<listOeManagement.size();i++){
			
			int price = listOeManagement.get(i).getDo_price(); 
			int nmt = listOeManagement.get(i).getDo_nmt();
			
		    supply_price  = price * nmt;
		    tax_amount = supply_price/10; 
			
			listOeManagement.get(i).setSupply_price(supply_price);
			listOeManagement.get(i).setTax_amount(tax_amount);
			
		}
		
		
		return listOeManagement;
	
	}

	/*수주 관리 리스트 count*/
	@Override
	public int countListOeManagement(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = oeManagementDao.countListOeManagement(paramMap); 
		
		return totalCount;
	}
	
	/*수주관리 Detail*/
	public OeManagementDtlModel DtlOeManagement(Map<String, Object> paramMap) throws Exception{
		
		System.out.println("DtlDeManagement Service paramMap:::::::::::"+paramMap);
		
		OeManagementDtlModel oeDtlCodModel =  oeManagementDao.selectOneDtlOeManagement(paramMap); 
		
		return  oeDtlCodModel; 
	}
	
	/*  수주관리 모달창 아랫단 리스트 조회  */
	public List<OeManagementDtlListModel>  DtlListOeManagement(Map<String, Object> paramMap) throws Exception{
		
		System.out.println("OeManagementDtlListModel ServiceImpl paramMap"+paramMap);
		
		List<OeManagementDtlListModel> oeDtlListCodModel = oeManagementDao.selectListModalValue(paramMap); 
		
		return oeDtlListCodModel; 
		
	}
	
	/* 수주관리 리스트 목록 카운트 조회 */
	public int selectListTotalModal(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = oeManagementDao.selectListTotalModal(paramMap);
		
		System.out.println("selectListTotalModal totalCount@@@@@@@@@@@@@@@@@@@@@"+totalCount);
		
		return totalCount;
	}
	
	//** 수주관리 저장 *//*
	public int insertOeModal(Map<String, Object> paramMap) throws Exception {
		
		int ret = oeManagementDao.insertOeModal(paramMap);

		return ret;
	}
	
	//** 수주관리 상세 저장 *//*
	public int InsertOeDtlModal(Map<String, Object> paramMap) throws Exception {
		
		String infoCheck= oeManagementDao.selectAlreadyInfo(paramMap); 
		
		System.out.println("infoCheck infoCheck:::::::::::::"+infoCheck);
		
		int ret = 0; 
		int ret2 = 0; 
		//DB에 정보가 존재하지 않을때만 Insert
		
		//값을 조회했을때 데이터가 없다면  insert
		//db에 이미있다면 insert x 
		if(infoCheck== "" ||infoCheck== null ){
			//수주관리 상세정보 Insert
			 ret = oeManagementDao.insertOeDtlModal(paramMap);
			 
			 //회계전표에도 Insert 
			 ret2 = oeManagementDao.insertTbantsl(paramMap);
			 
		}else{
			
		}
		
		System.out.println("InsertOeDtlModal paramMap@@@@@@@@@@@@@@"+paramMap);
		
		return ret;
	}


	public OeModalModel selectSUOeModal(Map<String, Object> paramMap) throws Exception {
		OeModalModel selectSUOeModal =oeManagementDao.selectSUOeModal(paramMap);
		
		System.out.println("여기 임플 "+ selectSUOeModal);
		return selectSUOeModal;
	}
	
	public OeModalModel oneDtlModal(Map<String, Object> paramMap) throws Exception {

		System.out.println("OeManagementImpl oneDtlModal paramMap:::::::"+paramMap);
		
		OeModalModel oneDtlModal =  oeManagementDao.selectOneModal(paramMap); 
		
		return oneDtlModal; 

	}
	
	public int deleteInEmpDvDtl(Map<String, Object> paramMap) throws Exception {
		
		System.out.println("deleteEmpDvDtl paramMap ::::"+paramMap);
		
		int ret =  oeManagementDao.deleteEmpDvDtl(paramMap); 
		int ins =  oeManagementDao.insertAntSl(paramMap);
		
		return ret; 

		
	}

}
