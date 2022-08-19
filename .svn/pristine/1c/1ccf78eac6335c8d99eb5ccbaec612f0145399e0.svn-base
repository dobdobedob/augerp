package kr.happyjob.study.taskCalendar.service;

import java.io.File;
import java.util.Date;
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
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.taskCalendar.dao.TaskCalendarDao;
import kr.happyjob.study.taskCalendar.model.TaskCalendarModel;


@Service
public class TaskCalendarServiceImpl implements TaskCalendarService {

	@Autowired
	TaskCalendarDao TaskCalendarDao;

	@Override
	public List<TaskCalendarModel> TaskCalendarList(Map<String, Object> paramMap) {
		return TaskCalendarDao.TaskCalendarList(paramMap);
	}

	@Override
	public List<TaskCalendarModel> TaskCalendarDetailList(Map<String, Object> paramMap) {
		return TaskCalendarDao.TaskCalendarDetailList(paramMap);
	}
}