package kr.happyjob.study.taskCalendar.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.taskCalendar.model.TaskCalendarModel;

public interface TaskCalendarDao {

	public List<TaskCalendarModel> TaskCalendarList(Map<String, Object> paramMap);

	public List<TaskCalendarModel> TaskCalendarDetailList(Map<String, Object> paramMap);

}
