package kr.happyjob.study.taskCalendar.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.taskCalendar.model.TaskCalendarModel;

public interface TaskCalendarService {

	public List<TaskCalendarModel> TaskCalendarList(Map<String, Object> paramMap);

	public List<TaskCalendarModel> TaskCalendarDetailList(Map<String, Object> paramMap);

}