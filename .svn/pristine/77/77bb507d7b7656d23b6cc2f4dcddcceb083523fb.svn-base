package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmppayaccDao;
import kr.happyjob.study.employee.model.EmppayaccModel;

@Service
public class EmppayaccServiceImpl implements EmppayaccService {
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   EmppayaccDao emppayaccdao;


@Override
public EmppayaccModel listEmployeeModel(Map<String, Object> paramMap) throws Exception {
	
	EmppayaccModel listEmployeeModel = emppayaccdao.listEmployeeModel(paramMap);

	return listEmployeeModel;
	
}


@Override
public EmppayaccModel listPayModel(Map<String, Object> paramMap) throws Exception {
	EmppayaccModel listPayModel = emppayaccdao.listPayModel(paramMap);
	
	return listPayModel;
}


  

}
