/******************************************************************************

  Copyright (C), 2017-2028

 ******************************************************************************
  File Name     : quick.em
  Version       : Initial Draft
  Author        : Leon
  Created       : 2018/2/13
  Last Modified :
  Description   : 宏功能定义
  Function List :
  History       :
  1.Date        : 2018年2月10日
    Author      : Leon
    Modification: 创建修改整理相关快捷输入功能宏定义
******************************************************************************/

/*
配置默认作者名字
*/
macro cfg_author()
{
	author_name = getreg(MYNAME)
	msg("Current author's name is \"@author_name@\".Do you want to change the author's name?")
	author_name = Ask("Current author's name is \"@author_name@\". Enter your new name:")
	if(strlen( author_name ) != 0)
	{
		if (author_name == "#")
		{
			setreg(MYNAME, "")
			msg("Clear the environment variable \"MYNAME\"!")
			return
		}
		setreg(MYNAME, author_name)
	}
}

/*
配置选择语言类型
*/
macro cfg_language()
{
	value = getreg(LANGUAGE)

	if(value != 1)
	{
		msg("Current language=\"@value@\" is Chinese. Do you want to change language?")
	}
	else
	{
		msg("Current language=\"@value@\" is English. Do you want to change language?")
	}

	set_value = Ask("Enter the value to set language. Chinese:\"0\"; Englisg:\"1\"")

	if ((set_value != 0) && (set_value != 1))
	{
		value = 0
		return
	}
	else if (curr_language == "#")
	{
		setreg ("LANGUAGE", "")
		msg("Clear the environment variable \"LANGUAGE\"!")
		return
	}
	else
	{
		value = set_value
	}

	if(language != 0)
	{
		//language = 1
	}

	setreg(LANGUAGE, value)
	value = getreg(LANGUAGE)
	if(value != 1)
	{
		msg("After change language=\"@value@\" is Chinese.")
	}
	else
	{
		msg("After change language=\"@value@\" is English.")
	}
}

/*
配置系统默认变量
*/
macro configure_system()
{
	cfg_language()
	cfg_author()
}

macro get_curr_window_buffer_handle()
{
	//Returns the handle of the active, front-most source file window, or returns hNil if no windows are open.
	handle = GetCurrentWnd()
	if (hNil == handle)
		stop
	//Returns the handle of the file buffer displayed in the window hwnd.
	handle = GetWndBuf(handle)
	return handle
}

/*
获取当前光标所在的行号
*/
macro get_curr_slect_line_num()
{
	//Returns the handle of the active, front-most source file window, or returns hNil if no windows are open.
	handle = GetCurrentWnd()
	if (hNil == handle)
		stop
	//Returns the handle of the file buffer displayed in the window hwnd.
	sel = GetWndSel(handle)
	line_num = sel.lnFirst
	return line_num
}

macro get_curr_window_slect()
{
	hwin = GetCurrentWnd()
	sel = GetWndSel(hwin)
	return sel
}

macro set_curr_slect_window()
{
	hwin = GetCurrentWnd()
	sel = GetWndSel(hwin)
	SetWndSel(hwin, sel)
}

/*
检测当前配置语言是否为英文
*/
macro test_language_is_english()
{
	ret = False
	language = getreg(LANGUAGE)
	if(language == 1)
	{
		ret = True
	}
	return ret
}

/*
获取当前的用户名称
*/
macro get_curr_autor_name()
{
	ret = getreg(MYNAME)
	if(strlen( ret ) == 0)
	{
		//如果未设置作者名称，则提示输入字符并配置作者名称
		ret = Ask("Enter your name:")
		setreg(MYNAME, ret)
	}
	return ret
}

/*
获取系统当前的时间
*/
macro get_system_time()
{
	data = nil
	data = GetSysTime(1)
	is_english = test_language_is_english()
	if(False == is_english)
	{
		year_unit = "年"
		month_unit = "月"
		day_unit = "日"
		msg_str = "无法获取系统时间！默认设置时间为 @data@"
	}
	else
	{
		separate = "/"
		year_unit = separate
		month_unit = separate
		day_unit = ""
		msg_str = "Can't get the system time！The default time is @data@"
	}
	if(strlen(data.date) == 0)
	{
		year= "2018"
		month = "01"
		day= "18"
		setreg(Year, year)
		setreg(Month, month)
		setreg(Day, day)
		data.Year= month
		data.Month = month
		data.Day = day
		data.Date = "@year@" # "@year_unit@" # "@month@" # "@month_unit@" # "@day@" # "@day_unit@"
		Msg(msg_str)
	}
	else
	{
		setreg(Year, data.Year)
		setreg(Month, data.Month)
		setreg(Day, data.Day)
		setreg(Date, data.date)
		data.Month = getreg(Month)
		data.Day = getreg(Day)
		data.Date = getreg(Date)
	}
	
	is_english = test_language_is_english()
	if(False == is_english)
	{
		year_unit = "年"
		month_unit = "月"
		day_unit = "日"
	}
	else
	{
		separate = "/"
		year_unit = separate
		month_unit = separate
		day_unit = ""
	}
	data.Date = cat(data.Year, year_unit)
	data.Date = cat(data.Date, data.Month)
	data.Date = cat(data.Date, month_unit)
	data.Date = cat(data.Date, data.Day)
	data.Date = cat(data.Date, day_unit)

	return data
}

/*
获取系统当前的时间日期
*/
macro get_system_time_date()
{
	sys_time = get_system_time();
	return sys_time.Date
}

macro get_copyright_str()
{
	valid_date_str = "2017-2028"
	is_english = test_language_is_english()
	if(True == is_english)
	{
		company_str = "HUIZHOU BLUEWAY ELECTRONICS Co., Ltd."
		temp_str = "  Copyright (C), @valid_date_str@, @company_str@"
	}
	else
	{
		company_str = "惠州市蓝微电子有限公司"
		temp_str = "  版权所有 (C), @valid_date_str@, @company_str@"
	}
	
	return temp_str
}

/*
获取分割行的格式字符串
*/
macro get_separator_line()
{
	DividingLine = "*****************************************************************************"
	//DividingLine = "-----------------------------------------------------------------------------"
	//DividingLine = "=============================================================================="
	return DividingLine;
}

/*
获取单行注释分割线
*/
function get_single_line_comments_str()
{
	DividingLine = get_separator_line()
	temp = "/*@DividingLine@*/"
	return temp;
}

/*
获取多行注释起始
*/
function get_multiline_comments_begin()
{
	DividingLine = get_separator_line()
	temp = "/*@DividingLine@"
	return temp;
}

/*
获取多行注释结尾
*/
function get_multiline_comments_end()
{
	DividingLine = get_separator_line()
	temp = " @DividingLine@*/"
	return temp;
}

/*****************************************************************************
 Prototype    : parse_file_path_name_extension
 Description  : 更新长按有效状态
 Input        : str  
 Output       : None
 Return Value : 字符串信息记录
	.full 绝对路径
	.path 文件所在目录
	.name = 文件名
	.suffix = 后缀名
  History        :
  1.Date         : 2018/2/13
    Author       : Leon
    Modification : Created function
*****************************************************************************/
function parse_file_path_name_extension(str)
{
	data = nil
	data.full = ""
	data.path = ""
	data.name = ""
	data.suffix = ""

	len = strlen(str)
	start_pos = 0
	end_pos = len
	dot_pos = len
	dir_pos = len
	dot_key = "."
	dir_key = "\\"
	if(len > 0)
	{
		data.full = str
		while(True)
		{
			len = len - 1
			character = strmid(str, len, len+1)
			if(character == dot_key)
			{
				dot_pos = len
				data.suffix = strmid(str, dot_pos, end_pos)
			}
			else if(character == dir_key)
			{
				dir_pos = len
				data.path = strmid(str, start_pos, dir_pos)
				data.name = strmid(str, dir_pos+strlen(dir_key), dot_pos)
				break
			}
			if(len <= 0)
				break
		}
		
		if(dir_pos == end_pos)
		{
			data.name = strmid(str, start_pos, dot_pos)
		}
	}

	return data
}

/*
获取文件名的后缀名类型
*/
macro get_filename_extension(str)
{
	data = parse_file_path_name_extension(str)
	return data.suffix
}

/*
获取不带文件名的后缀名类型字符串
*/
macro get_filename_no_extension(str)
{
	data = parse_file_path_name_extension(str)
	temp_str = cat(data.path, "\\")
	temp_str = cat(temp_str, data.name)
	
	return temp_str
}

/*
获取文件名不带路径和后缀名
*/
macro get_only_filename(str)
{
	data = parse_file_path_name_extension(str)
	return data.name
}

/*
获取文件名(包含后缀名)
*/
macro get_file_name(str)
{
	data = parse_file_path_name_extension(str)
	name_str = cat(data.name, data.suffix)

	return name_str
}

/*
获取版本信息
*/
macro get_version()
{
	Record = get_program_info ()
	return Record.versionMajor
}

/*
获取程序版本信息
*/
macro get_program_info()
{
	Record = ""
	Record.versionMajor = 2
	Record.versionMinor = 1
	return Record
}

/*
获取当前打开文件的绝对路径
*/
function get_curr_open_file_absolute_path()
{
	handle = GetCurrentBuf()
	if (handle == hNil)
		stop

	file_absolute_path = GetBufName(handle)
	return file_absolute_path
}

/*
获取当前行的字符
*/
macro get_curr_line_str()
{
	handle = get_curr_window_buffer_handle()
	if (handle == hNil)
		stop
	line_num = get_curr_slect_line_num()
	line_str = GetBufLine(handle, line_num)
	//msg("get_curr_line_str() :: handle=|@handle@|  line_num=|@line_num@|   line_str=|@line_str@|")
	return line_str
}

/*
获取美化左边对齐与缩进格式
*/
macro get_pretty_code_left_format()
{
	hwnd = GetCurrentWnd()
	if (hwnd == hNil)
	{
		msg("[warnning] (hwnd == hNil = @hwnd@) stop!")
		stop
	}

	line_str = get_curr_line_str()
	chTab = CharFromAscii(9)
	chSpace = CharFromAscii(32);
	// prepare a new indented blank line to be inserted.
	// keep white space on left and add a tab to indent.
	// this preserves the indentation level.
	ich = 0
	tab_num = 0
	space_num = 0
	left_is_all_tab = True
	//统计空格或tab字符的个数
	while (line_str[ich] == chSpace || line_str[ich] == chTab)
	{
		if (line_str[ich] == chSpace )
		{
			space_num++
			if(True == left_is_all_tab)
			{
				left_is_all_tab = False
			}
		}
		else if (line_str[ich] == chTab )
		{
			tab_num++
		}
		
		ich = ich + 1
	}

	retract = chTab //默认以tab字符作为缩进字符
	if(left_is_all_tab == False)
	{
		if(line_str[ich-1] == chSpace)
			retract = "    "
	}
	
	data = nil
	data.alignment = strmid(line_str, 0, ich)               //对齐行
	data.retract = strmid(line_str, 0, ich) # retract       //缩进行
	data.space_num = space_num                              //空格数量
	data.tab_num = tab_num                                  //tab数量
	//msg("data=|@data@| line_str=|@line_str@|")
	return data
}

/*
获取修改目信息内容
*/
macro get_revise_info(id_str, is_begin)
{
	temp_str = "END  "
	question_str = nil
	if(True == is_begin)
	{
		question_str = get_problem_number_str()
		temp_str = "BEGIN"
	}
	
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	action = get_revise_action_str(id_str)
	author_name = get_curr_autor_name()
	date_str = get_system_time_date()
	str = "@alignment@/* @temp_str@: @action@ by @author_name@, @date_str@ @question_str@*/"
	return str
}

/*
获取修改目的意图操作字符串
*/
macro get_revise_action_str(id_str)
{
	ret_str = nil
	if (id_str == "add")
	{
		ret_str = "Added"
	}
	else if (id_str == "delete")
	{
		ret_str = "Deleted"
	}
	else if (id_str == "modify")
	{
		ret_str = "Modified"
	}
	return ret_str
}

macro get_problem_number()
{
	problem_id = Nil           //"" – the empty string.
	problem_id = GetReg ("PNO")
	return problem_id
}

macro get_problem_number_str()
{
	ret_str = Nil
	problem_id = GetReg ("PNO")
	if(strlen(problem_id)>0)
	{
		is_english = test_language_is_english()
		if(True == is_english)
		{
			hint_str = "Problem NO."
		}
		else
		{
			hint_str = "问题单号"
		}
		ret_str = "   @hint_str@ : @problem_id@"
	}
	return ret_str
}

macro clear_promble_number()
{
	SetReg ("PNO", "")
}

macro add_promble_number()
{
	problem_id = ASK("Please Input problem number ");
	if(problem_id == "#")
	{
		problem_id = ""
		SetReg ("PNO", "")
	}
	else
	{
		SetReg ("PNO", problem_id)
	}
	return problem_id
}

/*
删除指定行
*/
macro delect_line(line_num)
{
	hbuf = get_curr_window_buffer_handle()
	DelBufLine(hbuf, line_num)
}

/*
插入分割线
*/
function insert_separator_single_comment_line(hbuf, num)
{
	temp = get_single_line_comments_str()
	InsBufLine(hbuf, num++, "@temp@")
	return num;
}

/*
在指定行插入字符串
*/
macro insert_line_string(line_num, line_str)
{
	handle = get_curr_window_buffer_handle()
	if (hNil == handle)
		stop
	InsBufLine(handle, line_num, line_str)
}

/*
在指定行上插入多行注释开始行
*/
macro insert_multiline_comments_begin(line_num)
{
	line_str = get_multiline_comments_begin()
	insert_line_string(line_num, line_str)
}

/*
在指定行上插入多行注释结束行
*/
macro insert_multiline_comments_end(line_num)
{
	line_str = get_multiline_comments_end()
	insert_line_string(line_num, line_str)
}

/*
在指定行上插入分割行
*/
macro insert_separator_line(line_num)
{
	line_str = get_separator_line()
	insert_line_string(line_num, line_str)
}

/*
在指定行上插入空行
*/
macro insert_blank_line(line_num)
{
	insert_line_string(line_num, "")
}

/*
在当前行上插入字符串行
*/
macro insert_curr_slect_line_string(line_str)
{
	line_num = get_curr_slect_line_num()
	handle = get_curr_window_buffer_handle()
	if (hNil == handle)
		stop
	InsBufLine(handle, line_num, line_str)
}

macro insert_function_name()
{
	hwnd = GetCurrentWnd()
	if (hwnd == hNil)
		stop
	sel = GetWndSel(hwnd)
	hbuf = GetWndBuf(hwnd)
	symbolname = GetCurSymbol()
	SetBufSelText(hbuf, symbolname)
}

/*
插入注释信息块说明
*/
macro insert_comment_string_section(hbuf, line_num, str)
{
	insert_multiline_comments_begin(line_num++)
	insert_line_string(line_num++, " * @str@")
	insert_multiline_comments_end(line_num++)
	insert_blank_line(line_num++)
	return line_num
}

macro insert_do_while()
{
	hwin = GetCurrentWnd()
	hbuf = get_curr_window_buffer_handle()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	sel = get_curr_window_slect()
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		insert_line_string( line_num, alignment)
		SetWndSel(hwin, sel)
	}
	
	val = expand_brace_large()
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		PutBufLine(hbuf, line_num+1, "@retract@#")
	}
	line = sel.lnLast + val.nLineCount
	PutBufLine(hbuf, line, "@alignment@}while ( # );")
	insert_line_string( line_num, "@alignment@do")
	
	search_forward()

	last_line = line_num+3
	return last_line
}

macro insert_while()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	
	line_num = sel.lnFirst
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		insert_line_string(line_num, alignment)
		SetWndSel(hwnd,sel)
	}
	val = expand_brace_large()
	
	temp_left = val.temp_left
	insert_line_string( line_num, "@alignment@while ( # )")
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		PutBufLine(hbuf, line_num+2, "@retract@#")
	}
	SetBufIns (hbuf, line_num, strlen(temp_left)+7)
	search_forward()
	
	last_line = line_num+3
	return last_line
}

macro insert_for()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	
	line_num = sel.lnFirst
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		insert_line_string( line_num, alignment)
		SetWndSel(hwnd,sel)
	}
	val = expand_brace_large()
	temp_left = val.temp_left
	insert_line_string(line_num, "@alignment@for ( # ; # ; # )")
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		PutBufLine(hbuf, line_num+2, "@retract@#")
	}
	sel.lnFirst = line_num
	sel.lnLast = line_num
	sel.ichFirst = 0
	sel.ichLim = 0
	SetWndSel(hwnd, sel)
	search_forward()
	if(True == test_language_is_english())
	{
		input_loop_variable_msg = "Please input loop variable."
	}
	else
	{
		input_loop_variable_msg = "请输入循环变量"
	}
	curr_value = ask(input_loop_variable_msg)
	PutBufLine(hbuf,line_num, "@temp_left@for ( @curr_value@ = # ; @curr_value@ # ; @curr_value@++ )")
	search_forward()

	last_line = line_num+3
	return last_line
}

macro insert_if()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	
	line_num = sel.lnFirst
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		insert_line_string( line_num, alignment)
		SetWndSel(hwnd,sel)
	}
	val = expand_brace_large()
	temp_left = val.temp_left
	insert_line_string( line_num, "@alignment@if ( # )")
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		PutBufLine(hbuf, line_num+2, "@retract@#")
	}

	search_forward()
	last_line = line_num+3
	return last_line
}

macro insert_else()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		insert_line_string( line_num, alignment)
		SetWndSel(hwnd,sel)
	}
	val = expand_brace_large()
	temp_left = val.temp_left
	insert_line_string( line_num, "@alignment@else")
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		PutBufLine(hbuf, line_num+2, "@retract@")
		SetBufIns (hbuf, line_num+2, strlen(alignment)+4)
		last_line = line_num+3
		return last_line
	}
	SetBufIns (hbuf, line_num, strlen(temp_left)+7)
	last_line = line_num+2
	return last_line
}

macro insert_else_if()
{
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	hbuf = get_curr_window_buffer_handle()
	line_num = get_curr_slect_line_num()
	PutBufLine(hbuf, line_num, alignment # "else if ( # )")
	insert_line_string( line_num + 1, "@alignment@" # "{")
	insert_line_string( line_num + 2, "@retract@" # "#")
	insert_line_string( line_num + 3, "@alignment@" # "}")
	last_line = line_num + 3
	return last_line
}

macro insert_if_else()
{
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	hbuf = get_curr_window_buffer_handle()
	line_num = get_curr_slect_line_num()
	PutBufLine(hbuf, line_num, alignment # "if ( # )")
	insert_line_string( line_num + 1, "@alignment@" # "{")
	insert_line_string( line_num + 2, "@retract@" # "#")
	insert_line_string( line_num + 3, "@alignment@" # "}")
	insert_line_string( line_num + 4, "@alignment@" # "else")
	insert_line_string( line_num + 5, "@alignment@" # "{")
	insert_line_string( line_num + 6, "@retract@" # ";")
	insert_line_string( line_num + 7, "@alignment@" # "}")
	last_line = line_num + 8
	return last_line
}

macro insert_if_elseif_else()
{
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	hbuf = get_curr_window_buffer_handle()
	line_num = get_curr_slect_line_num()
	hbuf = get_curr_window_buffer_handle()
	PutBufLine(hbuf, line_num, alignment # "if ( # )")
	insert_line_string( line_num + 1, "@alignment@" # "{")
	insert_line_string( line_num + 2, "@retract@" # "#")
	insert_line_string( line_num + 3, "@alignment@" # "}")
	insert_line_string( line_num + 4, "@alignment@" # "else if ( # )")
	insert_line_string( line_num + 5, "@alignment@" # "{")
	insert_line_string( line_num + 6, "@retract@" # ";")
	insert_line_string( line_num + 7, "@alignment@" # "}")
	insert_line_string( line_num + 8, "@alignment@" # "else")
	insert_line_string( line_num + 9, "@alignment@" # "{")
	insert_line_string( line_num + 10, "@retract@" # ";")
	insert_line_string( line_num + 11, "@alignment@" # "}")
	last_line = line_num + 12
	return last_line
}

macro insert_case()
{
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	insert_line_string( line_num + 0, "@alignment@" # "case # :")
	insert_line_string( line_num + 1, "@retract@" # "#")
	insert_line_string( line_num + 2, "@retract@" # "break;")
	search_forward()
	last_line = line_num + 2
	return last_line
}

macro insert_switch()
{
	hwnd = GetCurrentWnd()
	hbuf = GetCurrentBuf()
	save_selct = get_curr_window_slect()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	insert_line_string( line_num, "@alignment@switch ( # )")
	insert_line_string( line_num + 1, "@alignment@" # "{")
	if(True == test_language_is_english())
	{
		input_case_num_msg = "Please input the number of case. Automatic detection input 'a','A','0'or'#'."
	}
	else
	{
		input_case_num_msg = "请输入case的个数，根据粘帖板自动生成则输入‘a’或者‘0’或者‘#’。"
	}
	case_num = ask(input_case_num_msg)
	
	SetWndSel(hwnd, save_selct)
	last_line = insert_multi_case_proc(hbuf, alignment, retract, case_num)
	
	search_forward()
	return last_line
}

macro insert_enum()
{
	hbuf = GetCurrentBuf()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract

	if(True == test_language_is_english())
	{
		input_enum_name_msg = "Please input enum name."
	}
	else
	{
		input_enum_name_msg = "请输入枚举名"
	}
	struct_name = toupper(Ask(input_enum_name_msg))
	insert_line_string( line_num, "@alignment@typedef enum @struct_name@")
	insert_line_string( line_num + 1, "@alignment@{");
	insert_line_string( line_num + 2, "@retract@");
	struct_name = cat(struct_name, "_ENUM")
	insert_line_string( line_num + 3, "@alignment@}@struct_name@;")
	SetBufIns (hbuf, line_num + 2, strlen(retract))
	last_line = line_num + 3
	return last_line
}

macro insert_struct()
{
	hbuf = GetCurrentBuf()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	if(True == test_language_is_english())
	{
		input_struct_name_msg = "Please input struct name."
	}
	else
	{
		input_struct_name_msg = "请输入结构名称"
	}
	struct_name = toupper(Ask(input_struct_name_msg))
	insert_line_string( line_num, "@alignment@typedef struct @struct_name@")
	insert_line_string( line_num + 1, "@alignment@{");
	insert_line_string( line_num + 2, "@retract@");
	struct_name = cat(struct_name,"_STRU")
	insert_line_string( line_num + 3, "@alignment@}@struct_name@;")
	SetBufIns (hbuf, line_num + 2, strlen(retract))
	last_line = line_num + 3
	return last_line
}

macro insert_multi_case_proc(hbuf, alignment, retract, nSwitch)
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	line_num = get_curr_slect_line_num()
	nIdx = 0
	
	if((nSwitch == 0) || (nSwitch == "a") || (nSwitch == "A") || (nSwitch == "#"))
	{
		//根据粘贴板自动生成相应的数量case
		hNewBuf = newbuf("clip")
		if(hNewBuf == hNil)
			return
		SetCurrentBuf(hNewBuf)
		PasteBufLine (hNewBuf, 0)
		nLeftMax = 0
		lnMax = GetBufLineCount(hNewBuf )
		i = 0
		fIsEnd = 1
		while ( i < lnMax)
		{
			retract_line = GetBufLine(hNewBuf , i)
			//先去掉代码中注释的内容
			RetVal = skip_comment_from_string(retract_line, fIsEnd)
			retract_line = RetVal.content_str
			fIsEnd = RetVal.fIsEnd
			//从剪贴板中取得case值
			case_id_str = get_switch_var(retract_line)
			if(strlen(retract_line) != 0 )
			{
				SetCurrentBuf(hbuf)
				line_num = line_num + 3
				insert_line_string( line_num - 1, "@alignment@" # "case @case_id_str@ :")
				insert_line_string( line_num,     "@retract@" #        "#")
				insert_line_string( line_num + 1, "@retract@" #        "break;")
			}
			i = i + 1
		}
		closebuf(hNewBuf)
	}
	else
	{
		while(nIdx < nSwitch)
		{
			line_num = line_num + 3
			insert_line_string( line_num - 1, "@alignment@" # "case # :")
			insert_line_string( line_num,     "@retract@" #        "#")
			insert_line_string( line_num + 1, "@retract@" #        "break;")
			nIdx = nIdx + 1
		}
	}
	insert_line_string( line_num + 2, "@alignment@" # "default:")
	insert_line_string( line_num + 3, "@retract@" #        "#")
	insert_line_string( line_num + 4, "@alignment@" # "}")
	SetWndSel(hwnd, sel)
	search_forward()
	last_line = line_num + 4
	return last_line
}

macro insert_ifdef()
{
	temp_str = Ask("Enter #ifdef condition:")
	if (strlen(temp_str) == 0)
		stop
	hwnd = GetCurrentWnd()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	
	lnLast = GetWndSelLnLast(hwnd)
	hbuf = GetCurrentBuf()
	lnMax = GetBufLineCount(hbuf)
	if(lnLast + 1 < lnMax)
	{
		insert_line_string( line_num+1, "@retract@#")
		insert_line_string( line_num+2, "@alignment@#endif /* @temp_str@ */")
	}
	else if(lnLast + 1 == lnMax)
	{
		AppendBufLine(hbuf, "@alignment@#endif /* @temp_str@ */")
	}
	else
	{
		AppendBufLine(hbuf, "")
		AppendBufLine(hbuf, "@alignment@#endif /* @temp_str@ */")
	}
	insert_line_string( line_num, "@alignment@#ifdef @temp_str@")
	SetBufIns(hbuf, line_num + 1, strlen(alignment))
	last_line = line_num
	return last_line
}

macro insert_ifndef()
{
	temp_str = Ask("Enter #ifndef condition:")
	if (strlen(temp_str) == 0)
		stop
	hwnd = GetCurrentWnd()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	lnLast = GetWndSelLnLast(hwnd)
	hbuf = GetCurrentBuf()
	lnMax = GetBufLineCount(hbuf)
	if(lnLast + 1 < lnMax)
	{
		insert_line_string( line_num+1, "@retract@#")
		insert_line_string( line_num+2, "@alignment@#endif /* @temp_str@ */")
	}
	else if(lnLast + 1 == lnMax)
	{
		AppendBufLine(hbuf, "@alignment@#endif /* @temp_str@ */")
	}
	else
	{
		AppendBufLine(hbuf, "")
		AppendBufLine(hbuf, "@alignment@#endif /* @temp_str@ */")
	}
	insert_line_string(line_num, "@alignment@#ifndef @temp_str@")
	SetBufIns(hbuf, line_num + 1, strlen(alignment))
	last_line = line_num
	return last_line
}

macro insert_cplusplus(hbuf, line_num)
{
	temp = get_single_line_comments_str()
	insert_line_string( line_num, "")
	insert_line_string( line_num, "@temp@")
	insert_line_string( line_num, "#endif /* __cplusplus */")
	insert_line_string( line_num, "#endif")
	insert_line_string( line_num, "extern \"C\"{")
	insert_line_string( line_num, "#if __cplusplus")
	insert_line_string( line_num, "#ifdef __cplusplus")
	insert_line_string( line_num, "@temp@")

	line = GetBufLineCount (hbuf)
	insert_line_string( line, "@temp@")
	insert_line_string( line, "#endif /* __cplusplus */")
	insert_line_string( line, "#endif")
	insert_line_string( line, "}")
	insert_line_string( line, "#if __cplusplus")
	insert_line_string( line, "#ifdef __cplusplus")
	insert_line_string( line, "@temp@")
}

/*
插入文件头信息段
*/
macro insert_file_header_info()
{
	hbuf = get_curr_window_buffer_handle()
	if (hbuf == hNil)
		stop
	SetBufIns (hbuf, 0, 0)
	//插入文件头说明
	insert_file_header(hbuf, 0, "")
}

macro insert_revise_comment_proc(hbuf, ln, commend_str, author_name, alignment)
{
	date_str = get_system_time_date()
	question_str = get_problem_number_str()
	
	if (commend_str == "ap")
	{
		DelBufLine(hbuf, ln)
		question_v = add_promble_number()
		insert_line_string( ln, "@alignment@/* 问 题 单: @question_v@     修改人:@author_name@,   时间:@date_str@ ");
		content_str = Ask("修改原因")
		temp_left = cat(alignment_line,"   修改原因: ");
		if(strlen(temp_left) > 70)
		{
			Msg("The right margine is small, Please use a new line")
			stop
		}
		ln = comment_content(hbuf, ln + 1, temp_left, content_str, 1)
		return
	}
	else if (commend_str == "ab")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment@/* BEGIN: Added by @author_name@, @date_str@ @question_str@*/");
		return
	}
	else if (commend_str == "ae")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment@/* END:   Added by @author_name@, @date_str@ */");
		return
	}
	else if (commend_str == "db")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment@/* BEGIN: Deleted by @author_name@, @date_str@ @question_str@*/")
		return
	}
	else if (commend_str == "de")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment@/* END: Deleted by @author_name@, @date_str@ */")
		return
	}
	else if (commend_str == "mb")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment@/* BEGIN: Modified by @author_name@, @date_str@ @question_str@*/")
		return
	}
	else if (commend_str == "me")
	{
		DelBufLine(hbuf, ln)
		insert_line_string(ln, "@alignment_line@/* END:   Modified by @author_name@, @date_str@ */")
		return
	}
}

macro insert_revise_info(line_num, id_str, is_begin)
{
	str = get_revise_info(id_str, is_begin)
	insert_line_string( line_num, str)
	return line_num
}

macro insert_revise_add_begin(line_num)
{
	return insert_revise_info(line_num, "add", True)
}

macro insert_revise_add_end(line_num)
{
	return insert_revise_info(line_num, "add", False)
}

macro insert_revise(id_str)
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	line_sum = GetBufLineCount(hbuf)

	author_name = get_curr_autor_name()
	date_str = get_system_time_date()
	question_str = get_problem_number_str()

	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	line_num = sel.lnFirst
	insert_revise_info(line_num, id_str, True)

	last_line_num = line_sum - 1
	if(sel.lnLast < last_line_num)
	{
		insert_revise_info(sel.lnLast + 2, id_str, False)
	}
	else
	{
		str = get_revise_info(id_str, False)
		AppendBufLine(hbuf, str)
	}
	
	if(sel.lnFirst == sel.lnLast)
	{
		PutBufLine(hbuf, line_num+1, alignment)
	}
	SetBufIns(hbuf, line_num+1, strlen(alignment))
}

macro insert_revise_add()
{
	insert_revise("add")
}

macro insert_revise_del_begin(line_num)
{
	return insert_revise_info(line_num, "delete", True)
}

macro insert_revise_del_end(line_num)
{
	return insert_revise_info(line_num, "delete", False)
}

macro insert_revise_del()
{
	insert_revise("delete")
}

macro insert_revise_modify_begin(line_num)
{
	return insert_revise_info(line_num, "modify", True)
}

macro insert_revise_modify_end(line_num)
{
	return insert_revise_info(line_num, "modify", False)
}

macro insert_revise_modify()
{
	insert_revise("modify")
}

macro insert_history_content(hbuf, line_num, iHostoryCount)
{
	date_str = get_system_time_date()
	author_name = get_curr_autor_name()

	language_is_english = test_language_is_english()
	if(True == language_is_english)
	{
		data_str = "Date         "
		autor_str = "    Author       "
		msg_str = "Please input modification"
		modification_str = "    Modification : "
	}
	else
	{
		data_str = "日    期  "
		autor_str = "    作    者   "
		msg_str = "请输入修改的内容"
		modification_str = "    修改内容   : "
	}
	
	insert_line_string( line_num, "")
	insert_line_string( line_num + 1, "  @iHostoryCount@.@data_str@: @date_str@")

	insert_line_string( line_num + 2, autor_str)
	content_str = Ask(msg_str)
	comment_content(hbuf, line_num + 3, modification_str, content_str, 0)
}

macro insert_history_info(hbuf, line_num)
{
	history_count = 0
	const_value = 0xffffffff
	i = 0
	while(line_num-i>0)
	{
		curr_line = GetBufLine(hbuf, line_num-i)
		begin1 = string_cmp(curr_line, "日    期  ")
		begin2 = string_cmp(curr_line, "Date      ")
		if((begin1 != const_value) || (begin2 != const_value))
		{
			i++
			history_count++
			continue
		}
		begin1 = string_cmp(curr_line, "修改历史")
		begin2 = string_cmp(curr_line, "History      ")
		if((begin1 != const_value) || (begin2 != const_value))
		{
			break
		}
		iBeg = string_cmp(curr_line, "/**********************")
		if( iBeg != const_value )
		{
			break
		}
		i++
	}
	
	insert_history_content(hbuf, line_num, history_count)
}

macro insert_promble_description()
{
	hwnd = GetCurrentWnd()
	line_num = get_curr_slect_line_num()
	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract

	author_name = get_curr_autor_name()
	date_str = get_system_time_date()
	question_str = get_problem_number_str()
	
	promble_id = add_promble_number()

	if(True == test_language_is_english())
	{
		use_new_line_msg = "The right margine is small, Please use a new line."
		input_description_msg = "   Description    : "
	}
	else
	{
		use_new_line_msg = "右边空间太小,请用新的行."
		input_description_msg = "   Description    : "
	}
	
	insert_line_string( line_num, "@alignment@/* Promblem Number: @promble_id@     [Author:@author_name@ | Date:@date_str@ ]");

	content_str = Ask(input_description_msg)
	temp_left = cat(alignment, input_description_msg);
	if(strlen(temp_left) > 70)
	{
		msg(use_new_line_msg)
		stop
	}
	line_num = comment_content(hbuf, line_num + 1, temp_left, content_str, 1)
	last_line = line_num+1
	return last_line
}

macro insert_pre_def_if()
{
	temp_str = Ask("Enter #if condition:")
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
	hbuf = GetCurrentBuf()
	lnMax = GetBufLineCount(hbuf)
	if(lnMax != 0)
	{
		retract_line = GetBufLine( hbuf, lnFirst )
	}
	nLeft = get_left_blank(retract_line)
	temp_left = strmid(retract_line,0,nLeft);

	hbuf = GetCurrentBuf()
	if(lnLast + 1 < lnMax)
	{
		insert_line_string( lnLast+1, "@temp_left@#endif /* #if @temp_str@ */")
	}
	else if(lnLast + 1 == lnMax)
	{
		AppendBufLine(hbuf, "@temp_left@#endif /* #if @temp_str@ */")
	}
	else
	{
		AppendBufLine(hbuf, "")
		AppendBufLine(hbuf, "@temp_left@#endif /* #if @temp_str@ */")
	}
	insert_line_string( lnFirst, "@temp_left@#if  @temp_str@")
	SetBufIns(hbuf,lnFirst + 1,strlen(temp_left))
}

macro insert_comment()
{
	hbuf = GetCurrentBuf()
	line_num = get_curr_slect_line_num()
	line_str = get_curr_line_str()
	sel = get_curr_window_slect()
	wordinfo = get_word_left_of_ich(sel.ichFirst, line_str)
	if(wordinfo.ichLim > 70)
	{
		Msg(use_new_line_msg)
		stop
	}

	line_len = strlen(line_str)
	i = 0
	while(wordinfo.ichLim + i < line_len)
	{
		if((line_str[wordinfo.ichLim + i] != " ")||(line_str[wordinfo.ichLim + i] != "\t")
		{
			msg("you must insert /* at the end of a line");
			return
		}
		i = i + 1
	}
	
	if(True == test_language_is_english())
	{
		msg_str = "Please input comment."
	}
	else
	{
		msg_str = "请输入注释的内容。"
	}
	
	DelBufLine(hbuf, line_num)
	content_str = Ask(msg_str)
	temp_left = cat( line_str, " ")
	comment_content(hbuf, line_num, temp_left, content_str, 1)
	return line_num
}

/*
添加文件头部信息
*/
macro insert_file_header(hbuf, ln, content_str)
{
	hnewbuf = newbuf("")
	if(hnewbuf == hNil)
	{
		stop
	}

	is_english = test_language_is_english()
	if(True == is_english)
	{
		file_name_str =          "  File Name     "
		version_str =            "  Version       "
		author_str =             "  Author        "
		created_str =            "  Created       "
		last_dodified_str =      "  Last Modified "
		description_str =        "  Description   "
		function_list_str =      "  Function List "
		history_str =            "  History       "
		date_str =               "  1.Date        "
		mender_str =             "    Author      "
		modification_str =       "    Modification"
		prototypes_str =         "prototypes"
		difinition_str =         "difinition"
		initial_draft_str =      "Initial Draft"

		header_files_str =       "include header files list"
		external_variables_str = "external variables"
		external_function_str =  "external function "
		global_variables_str =   "project-wide global variables"
		macros_str =             "macros"
		constants_str =          "constants"
		enum_str =               "enum"
		struct_str =             "struct"
		class_str =              "class"
		internal_function_str =  "internal function"
		input_description_msg =  "Please input the description of the file."
	}
	else
	{
		file_name_str =          "  文件名称"
		version_str =            "  版本编号"
		author_str =             "  作     者"
		created_str =            "  生成日期"
		last_dodified_str =      "  最近修改"
		description_str =        "  功能描述"
		function_list_str =      "  函数列表"
		history_str =            "  修改历史"
		date_str =               "  1.日     期"
		mender_str =             "    作     者"
		modification_str =       "    修改内容"
		prototypes_str =         "声明"
		difinition_str =         "定义"
		initial_draft_str =      "初稿"

		header_files_str =       "包含头文件"
		external_variables_str = "外部变量"
		external_function_str =  "外部函数"
		global_variables_str =   "全局变量"
		macros_str =             "宏"
		constants_str =          "常量"
		enum_str =               "枚举"
		struct_str =             "结构体"
		class_str =              "类"
		internal_function_str =  "内部函数"
		input_description_msg =  "请输入文件功能描述的内容"
	}

	copyright_str = get_copyright_str()
	autor_name = get_curr_autor_name()
	curr_date_str = get_system_time_date()
	
	name_str = "#"
	if( strlen(author_name) > 0 )
	{
		name_str = autor_name
	}
	
	get_function_list(hbuf, hnewbuf)
	
	temp_str = get_file_name(GetBufName(hbuf))
	insert_multiline_comments_begin(ln)
	insert_line_string( ln + 1, "")
	insert_line_string( ln + 2, "@copyright_str@")
	insert_line_string( ln + 3, "")
	insert_separator_line(ln + 4)
	insert_line_string( ln + 5, "@file_name_str@ : @temp_str@")
	insert_line_string( ln + 6, "@version_str@ : @initial_draft_str@")
	insert_line_string( ln + 7, "@author_str@ : @autor_name@")
	insert_line_string( ln + 8, "@created_str@ : @curr_date_str@")
	insert_line_string( ln + 9, "@last_dodified_str@ :")
	
	description_line_num = ln + 10
	insert_line_string( ln + 10, "@description_str@ : @content_str@")
	insert_line_string( ln + 11, "@function_list_str@ :")

	//插入函数列表
	ln = insert_file_list(hbuf, hnewbuf, ln + 12) - 12
	closebuf(hnewbuf)
	
	insert_line_string( ln + 12, "@history_str@ :")
	insert_line_string( ln + 13, "@date_str@ : @curr_date_str@")
	insert_line_string( ln + 14, "@mender_str@ : @name_str@")
	insert_line_string( ln + 15, "@modification_str@ : Created file")
	insert_multiline_comments_end(ln + 16)
	insert_blank_line( ln + 17)
	
	describe_str = ""
	file_type = get_curr_file_type()
	if( hxx == file_type)
	{
		describe_str = prototypes_str
	}
	else if( cxx == file_type)
	{
		describe_str = difinition_str
	}

	curr_line = ln + 18
	curr_line = insert_comment_string_section(hbuf, curr_line, "@header_files_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@external_variables_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@external_function_str@ @describe_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@global_variables_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@macros_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@constants_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@enum_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "struct")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@class_str@ @describe_str@")
	curr_line = insert_comment_string_section(hbuf, curr_line, "@internal_function_str@ @describe_str@")

	if(strlen(content_str) != 0)
	{
		return
	}
	
	content_str = Ask(input_description_msg)       //如果没有输入功能描述的话提示输入
	SetBufIns(hbuf, 21, 0)                         //设置光标位置
	DelBufLine(hbuf, description_line_num)         //删除原始描述行添加描述信息
	comment_content(hbuf, description_line_num, "@description_str@ : ", content_str, 0) //在删除原始描述行添加描述信息
}

macro insert_file_list(hbuf, hnewbuf,ln)
{
	if(hnewbuf == hNil)
	{
		return ln
	}
	isymMax = GetBufLineCount (hnewbuf)
	isym = 0
	while (isym < isymMax)
	{
		retract_line = GetBufLine(hnewbuf, isym)
		insert_line_string(ln,"              @retract_line@")
		ln = ln + 1
		isym = isym + 1
	}
	return ln
}

macro insert_trace_in_curr_function(hbuf,symbol)
{
	ln = GetBufLnCur (hbuf)
	symbolname = symbol.Symbol
	nLineEnd = symbol.lnLim
	nExitCount = 1;
	insert_line_string( ln, "    DebugTrace(\"\\r\\n |@symbolname@() entry--- \");")
	ln = ln + 1
	fIsEnd = 1
	fIsNeedPrt = 1
	fIsSatementEnd = 1
	curr_LeftOld = ""
	while(ln < nLineEnd)
	{
		retract_line = GetBufLine(hbuf, ln)
		iCurLineLen = strlen(retract_line)

		/*剔除其中的注释语句*/
		RetVal = skip_comment_from_string(retract_line,fIsEnd)
		retract_line = RetVal.content_str
		fIsEnd = RetVal.fIsEnd
		//查找是否有return语句
		/*
		ret =string_cmp(retract_line,"return")
		if(ret != 0xffffffff)
		{
			if( (retract_line[ret+6] == " " ) || (retract_line[ret+6] == "\t" )
				|| (retract_line[ret+6] == ";" ) || (retract_line[ret+6] == "(" ))
			{
				curr_Pre = strmid(retract_line,0,ret)
			}
			SetBufIns(hbuf,ln,ret)
			Paren_Right
			sel = GetWndSel(hwnd)
			if( sel.lnLast != ln )
			{
				GetbufLine(hbuf,sel.lnLast)
				RetVal = skip_comment_from_string(retract_line,1)
				retract_line = RetVal.content_str
				fIsEnd = RetVal.fIsEnd
			}
		}
		*/
		//获得左边空白大小
		nLeft = get_left_blank(retract_line)
		if(nLeft == 0)
		{
			temp_left = "    "
		}
		else
		{
			temp_left = strmid(retract_line,0,nLeft)
		}
		retract_line = trim_string(retract_line)
		iLen = strlen(retract_line)
		if(iLen == 0)
		{
			ln = ln + 1
			continue
		}
		curr_Ret = get_first_word(retract_line)
//        if( (curr_Ret == "if") || (curr_Ret == "else")
		//查找是否有return语句
//        ret =string_cmp(retract_line,"return")

		if( curr_Ret == "return")
		{
			if( fIsSatementEnd == 0)
			{
				fIsNeedPrt = 1
				insert_line_string(ln+1,"@curr_LeftOld@}")
				curr_End = cat(temp_left,"DebugTrace(\"\\r\\n |@symbolname@() exit---: @nExitCount@ \");")
				insert_line_string( ln, curr_End )
				insert_line_string(ln,"@curr_LeftOld@{")
				nExitCount = nExitCount + 1
				nLineEnd = nLineEnd + 3
				ln = ln + 3
			}
			else
			{
				fIsNeedPrt = 0
				curr_End = cat(temp_left,"DebugTrace(\"\\r\\n |@symbolname@() exit---: @nExitCount@ \");")
				insert_line_string( ln, curr_End )
				nExitCount = nExitCount + 1
				nLineEnd = nLineEnd + 1
				ln = ln + 1
			}
		}
		else
		{
			ret =string_cmp(retract_line,"}")
			if( ret != 0xffffffff )
			{
				fIsNeedPrt = 1
			}
		}

		curr_LeftOld = temp_left
		ch = retract_line[iLen-1]
		if( ( ch  == ";" ) || ( ch  == "{" )
			 || ( ch  == ":" )|| ( ch  == "}" ) || ( retract_line[0] == "#" ))
		{
			fIsSatementEnd = 1
		}
		else
		{
			fIsSatementEnd = 0
		}
		ln = ln + 1
	}

	//只要前面的return后有一个}了说明函数的结尾没有返回，需要再加一个出口打印
	if(fIsNeedPrt == 1)
	{
		insert_line_string( ln,  "    DebugTrace(\"\\r\\n |@symbolname@() exit---: @nExitCount@ \");")
		insert_line_string( ln,  "")
	}
}

macro auto_insert_trace_info_in_buffer()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	hbuf = GetWndBuf(hwnd)

	isymMax = GetBufSymCount(hbuf)
	isym = 0
	while (isym < isymMax)
	{
		symbol = GetBufSymLocation(hbuf, isym)
		isCodeBegin = 0
		fIsEnd = 1
		isBlandLine = 0
		if(strlen(symbol) > 0)
		{
			if(symbol.Type == "Class Placeholder")
			{
				hsyml = SymbolChildren(symbol)
				cchild = SymListCount(hsyml)
				ichild = 0
				while (ichild < cchild)
				{
					symbol = GetBufSymLocation(hbuf, isym)
					hsyml = SymbolChildren(symbol)
					childsym = SymListItem(hsyml, ichild)
					ln = childsym.lnName
					isCodeBegin = 0
					fIsEnd = 1
					isBlandLine = 0
					while( ln < childsym.lnLim )
					{
						retract_line = GetBufLine (hbuf, ln)
						//去掉注释的干扰
						RetVal = skip_comment_from_string(retract_line,fIsEnd)
						curr_New = RetVal.content_str
						fIsEnd = RetVal.fIsEnd
						if(isCodeBegin == 1)
						{
							curr_New = trim_left(curr_New)
							//检测是否是可执行代码开始
							iRet = check_is_code_begin(curr_New)
							if(iRet == 1)
							{
								if( isBlandLine != 0 )
								{
									ln = isBlandLine
								}
								insert_line_string(ln,"")
								childsym.lnLim = childsym.lnLim + 1
								SetBufIns(hbuf, ln+1 , 0)
								insert_trace_in_curr_function(hbuf,childsym)
								break
							}
							if(strlen(curr_New) == 0)
							{
								if( isBlandLine == 0 )
								{
									isBlandLine = ln;
								}
							}
							else
							{
								isBlandLine = 0
							}
						}
						//查找到函数的开始
						if(isCodeBegin == 0)
						{
							iRet = string_cmp(curr_New,"{")
							if(iRet != 0xffffffff)
							{
								isCodeBegin = 1
							}
						}
						ln = ln + 1
					}
					ichild = ichild + 1
				}
				SymListFree(hsyml)
			}
			else if( ( symbol.Type == "Function") ||  (symbol.Type == "Method") )
			{
				ln = symbol.lnName
				while( ln < symbol.lnLim )
				{
					retract_line = GetBufLine (hbuf, ln)
					//去掉注释的干扰
					RetVal = skip_comment_from_string(retract_line,fIsEnd)
					curr_New = RetVal.content_str
					fIsEnd = RetVal.fIsEnd
					if(isCodeBegin == 1)
					{
						curr_New = trim_left(curr_New)
						//检测是否是可执行代码开始
						iRet = check_is_code_begin(curr_New)
						if(iRet == 1)
						{
							if( isBlandLine != 0 )
							{
								ln = isBlandLine
							}
							SetBufIns(hbuf, ln , 0)
							insert_trace_in_curr_function(hbuf,symbol)
							insert_line_string(ln,"")
							break
						}
						if(strlen(curr_New) == 0)
						{
							if( isBlandLine == 0 )
							{
								isBlandLine = ln;
							}
						}
						else
						{
							isBlandLine = 0
						}
					}
					//查找到函数的开始
					if(isCodeBegin == 0)
					{
						iRet = string_cmp(curr_New,"{")
						if(iRet != 0xffffffff)
						{
							isCodeBegin = 1
						}
					}
					ln = ln + 1
				}
			}
		}
		isym = isym + 1
	}

}

/*
自定义自动扩展命令功能
*/
macro auto_expand()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop

	line_num = get_curr_slect_line_num()
	sel = GetWndSel(hwnd)
	if(sel.lnFirst != sel.lnLast)
	{
		/*块命令处理*/
		block_command_proc()
	}
	
	if (sel.ichFirst == 0)
		stop
	
	hbuf = get_curr_window_buffer_handle()
	ln = line_num//当前所在行
	// parse word just to the left of the insertion point
	line_str = get_curr_line_str()
	wordinfo = get_word_left_of_ich(sel.ichFirst, line_str)

	sel.lnFirst = sel.lnLast
	sel.ichFirst = wordinfo.ich
	sel.ichLim = wordinfo.ich

	//自动完成简化命令的匹配显示
	wordinfo.word = restore_command(hbuf, wordinfo.word)
	//msg(cat("auto_expand() :: wordinfo =", wordinfo.word)
	sel = GetWndSel(hwnd)

	if (wordinfo.word == "pn") //问题单号的处理
	{
		delect_line(ln)
		add_promble_number()
		return
	}
	else if (wordinfo.word == "config" || wordinfo.word == "co") //配置命令执行
	{
		delect_line(ln)
		configure_system()
		return
	}
	else if (wordinfo.word == "hi") //修改历史记录更新
	{
		delect_line(ln)
		insert_history_info(hbuf, ln)
		return
	}
	else if (wordinfo.word == "abg")
	{
		insert_revise_add()
		return
	}
	else if (wordinfo.word == "dbg")
	{
		insert_revise_del()
		return
	}
	else if (wordinfo.word == "mbg")
	{
		insert_revise_modify()
		return
	}
	
	expand_proc(wordinfo.word, ln)
}

macro expand_proc(key_str, line_num)
{
	
	if (key_str == "/*") //插入"/* */"风格的注释
	{
		insert_comment()
		return
	}
	else if(key_str == "{")
	{
		expand_brace_large()
		delect_line(line_num)
		return
	}
	else if (key_str == "while" )
	{
		line_num = insert_while()
		delect_line(line_num+1)
	}
	else if( key_str == "else" )
	{
		line_num = insert_else()
		delect_line(line_num+1)
		return
	}
	else if (key_str == "#ifdef")
	{
		line_num = insert_ifdef()
		delect_line(line_num+1)
		return
	}
	else if (key_str == "#ifndef")
	{
		line_num = insert_ifndef()
		delect_line(line_num+1)
		return
	}
	else if (key_str == "#if")
	{
		delect_line(line_num)
		insert_pre_def_if()
		return
	}
	else if (key_str == "cpp")
	{
		delect_line(line_num)
		insert_cplusplus(hbuf, line_num)
		return
	}
	else if (key_str == "if")
	{
		line_num = insert_if()
		delect_line(line_num+1)
	}
	else if (key_str == "ef")
	{
		line_num = insert_else_if()
		delect_line(line_num+1)
	}
	else if (key_str == "ife")
	{
		line_num = insert_if_else()
		delect_line(line_num+1)
	}
	else if (key_str == "ifs")
	{
		line_num = insert_if_elseif_else()
		delect_line(line_num+1)
	}
	else if (key_str == "for")
	{
		line_num = insert_for()
		delect_line(line_num+1)
	}
	else if (key_str == "switch" )
	{
		line_num = insert_switch()
		delect_line(line_num+1)
	}
	else if (key_str == "do")
	{
		line_num = insert_do_while()
		delect_line(line_num+1)
	}
	else if (key_str == "case" )
	{
		line_num = insert_case()
		delect_line(line_num+1)
	}
	else if (key_str == "struct")
	{
		line_num = insert_struct()
		delect_line(line_num+1)
	}
	else if (key_str == "enum")
	{
		line_num = insert_enum()
		delect_line(line_num+1)
	}
	else if (key_str == "file")
	{
		delect_line(line_num)
		insert_file_header(hbuf, 0, "")//插入文件头说明
		return
	}
	else if (key_str == "function")
	{
		delect_line(line_num)
		create_function_header()//插入功能函数头说明
	}
	else if (key_str == "tab")
	{
		delect_line(line_num)
		replace_buffer_tab()
		return
	}
	else if (key_str == "hd")
	{
		delect_line(line_num)
		create_function_def(hbuf)//生成C语言的头文件
		return
	}
	else if (key_str == "hdn")
	{
		delect_line(line_num)
		create_new_header_file()//生成不要文件名的新头文件
		return
	}
	else if (key_str == "ap")
	{
		line_num = insert_promble_description()
		delect_line(line_num)
		return
	}
	else if (key_str == "ab")
	{
		line_num = insert_revise_add_begin(line_num)
		delect_line(line_num+1)
		return
	}
	else if (key_str == "ae")
	{
		line_num = insert_revise_add_end(line_num)
		delect_line(line_num+1)
		return
	}
	else if (key_str == "db")
	{
		line_num = insert_revise_del_begin(line_num)
		delect_line(line_num+1)
		return
	}
	else if (key_str == "de")
	{
		line_num = insert_revise_del_end(line_num)
		delect_line(line_num+1)
		return
	}
	else if (key_str == "mb")
	{
		line_num = insert_revise_modify_begin(line_num)
		delect_line(line_num+1)
		return
	}
	else if (key_str == "me")
	{
		line_num = insert_revise_modify_end(line_num)
		delect_line(line_num+1)
		return
	}
	else
	{
		search_forward()
		stop
	}

	search_forward()
}

macro block_command_proc()
{
//	hwnd = GetCurrentWnd()
//	if (hwnd == 0)
//		stop
//	sel = GetWndSel(hwnd)
//	hbuf = GetWndBuf(hwnd)
//	if(sel.lnFirst > 0)
//	{
//		ln = sel.lnFirst - 1
//	}
//	else
//	{
//		stop
//	}
//	line_str = GetBufLine(hbuf,ln)
	line_num = get_curr_slect_line_num()
	if(line_num > 0)
	{
		line_num--
	}
	
	line_str = get_curr_line_str()
	key_str = trim_string(line_str)
	if(key_str == "while" || key_str == "wh")
	{
		insert_while()                    //插入while
	}
	else if(key_str == "do")
	{
		insert_do_while()                 //插入do while语句
	}
	else if(key_str == "for")
	{
		insert_for()                      //插入for语句
	}
	else if(key_str == "if")
	{
		insert_if()                       //插入if语句
	}
	else if(key_str == "el" || key_str == "else")
	{
		insert_else()                     //插入else语句
		delect_line(line_num)
		stop
	}
	else if((key_str == "#ifd") || (key_str == "#ifdef"))
	{
		insert_ifdef()                    //插入#ifdef
		delect_line(line_num)
		stop
	}
	else if((key_str == "#ifn") || (key_str == "#ifndef"))
	{
		insert_ifndef()                   //插入#ifdef
		delect_line(line_num)
		stop
	}
	else if (key_str == "abg")
	{
		key_str()
		delect_line(line_num)
		stop
	}
	else if (key_str == "dbg")
	{
		insert_revise_del()
		delect_line(line_num)
		stop
	}
	else if (key_str == "mbg")
	{
		insert_revise_modify()
		delect_line(line_num)
		stop
	}
	else if(key_str == "#if")
	{
		insert_pre_def_if()
		delect_line(line_num)
		stop
	}
	delect_line(line_num)
	search_forward()
	stop
}

/*
修复补全关键字
*/
macro restore_command(hbuf, key_str)
{
	if(key_str == "ca")
	{
		SetBufSelText(hbuf, "se")
		key_str = "case"
	}
	else if(key_str == "sw")
	{
		SetBufSelText(hbuf, "itch")
		key_str = "switch"
	}
	else if(key_str == "el")
	{
		SetBufSelText(hbuf, "se")
		key_str = "else"
	}
	else if(key_str == "wh")
	{
		SetBufSelText(hbuf, "ile")
		key_str = "while"
	}
	else if (key_str == "#ifd" 
		|| key_str == "#ifde"
		|| key_str == "#ifde")
	{
		key_str = "#ifdef"
	}
	else if (key_str == "#ifn" 
		|| key_str == "#ifnd"
		|| key_str == "#ifnde")
	{
		key_str = "#ifndef"
	}
	else if (key_str == "st" 
		|| key_str == "str" 
		|| key_str == "stru"
		|| key_str == "struc")
	{
		key_str = "struct"
	}
	else if (key_str == "en" 
		|| key_str == "enu")
	{
		key_str = "enum"
	}
	else if (key_str == "file" || key_str == "fi")
	{
		key_str = "file"
	}
	else if (key_str == "func" || key_str == "fu")
	{
		key_str = "function"
	}
	return key_str
}

macro search_forward()
{
	/*
	LoadSearchPattern(pattern, fMatchCase, fRegExp, fWholeWordsOnly)

	Loads the search pattern used for the Search, Search Forward, and Search Backward commands.
The search pattern string is given in pattern. 
	If fMatchCase, then the search is case sensitive.
	If fRegExpr, then the pattern contains a regular expression. Otherwise, the pattern is a simple string.
	If fWholeWordsOnly then only whole words will cause a match.
	*/
	LoadSearchPattern("#", 1, 0, 1);
	Search_Forward
}

macro search_backward()
{
	LoadSearchPattern("#", 1, 0, 1);
	Search_Backward
}

macro string_cmp(str1,str2)
{
	i = 0
	j = 0
	len1 = strlen(str1)
	len2 = strlen(str2)
	if((len1 == 0) || (len2 == 0))
	{
		return 0xffffffff
	}
	while( i < len1)
	{
		if(str1[i] == str2[j])
		{
			while(j < len2)
			{
				j = j + 1
				if(str1[i+j] != str2[j])
				{
					break
				}
			}
			if(j == len2)
			{
				return i
			}
			j = 0
		}
		i = i + 1
	}
	return 0xffffffff
}

macro insert_trace_info()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	hbuf = GetWndBuf(hwnd)
	sel = GetWndSel(hwnd)
	symbol = GetSymbolLocationFromLn(hbuf, sel.lnFirst)
	insert_trace_in_curr_function(hbuf, symbol)
}

macro get_first_word(retract_line)
{
	retract_line = trim_left(retract_line)
	nIdx = 0
	iLen = strlen(retract_line)
	while(nIdx < iLen)
	{
		if( (retract_line[nIdx] == " ") || (retract_line[nIdx] == "\t")
		|| (retract_line[nIdx] == ";") || (retract_line[nIdx] == "(")
		|| (retract_line[nIdx] == ".") || (retract_line[nIdx] == "{")
		|| (retract_line[nIdx] == ",") || (retract_line[nIdx] == ":") )
		{
			return strmid(retract_line,0,nIdx)
		}
		nIdx = nIdx + 1
	}
	return retract_line //return ""
}

macro check_is_code_begin(retract_line)
{
	iLen = strlen(retract_line)
	if(iLen == 0)
	{
		return 0
	}
	nIdx = 0
	nWord = 0
	if( (retract_line[nIdx] == "(") || (retract_line[nIdx] == "-")
	|| (retract_line[nIdx] == "*") || (retract_line[nIdx] == "+"))
	{
		return 1
	}
	if( retract_line[nIdx] == "#" )
	{
		return 0
	}
	while(nIdx < iLen)
	{
		if( (retract_line[nIdx] == " ")||(retract_line[nIdx] == "\t")
			 || (retract_line[nIdx] == "(")||(retract_line[nIdx] == "{")
			 || (retract_line[nIdx] == ";") )
		{
			if(nWord == 0)
			{
				if( (retract_line[nIdx] == "(")||(retract_line[nIdx] == "{")
						 || (retract_line[nIdx] == ";")  )
				{
					return 1
				}
				curr_FirstWord = StrMid(retract_line,0,nIdx)
				if(curr_FirstWord == "return")
				{
					return 1
				}
			}
			while(nIdx < iLen)
			{
				if( (retract_line[nIdx] == " ")||(retract_line[nIdx] == "\t") )
				{
					nIdx = nIdx + 1
				}
				else
				{
					break
				}
			}
			nWord = nWord + 1
			if(nIdx == iLen)
			{
				return 1
			}
		}
		if(nWord == 1)
		{
			asciiA = AsciiFromChar("A")
			asciiZ = AsciiFromChar("Z")
			ch = toupper(retract_line[nIdx])
			asciiCh = AsciiFromChar(ch)
			if( ( retract_line[nIdx] == "_" ) || ( retract_line[nIdx] == "*" )
				 || ( ( asciiCh >= asciiA ) && ( asciiCh <= asciiZ ) ) )
			{
				return 0
			}
			else
			{
				return 1
			}
		}
		nIdx = nIdx + 1
	}
	return 1
}

macro auto_insert_trace_info_in_proj()
{
	hprj = GetCurrentProj()
	ifileMax = GetProjFileCount (hprj)
	ifile = 0
	while (ifile < ifileMax)
	{
		filename = GetProjFileName (hprj, ifile)
		curr_Ext = toupper(get_filename_extension(filename))
		if( (curr_Ext == "C") || (curr_Ext == "CPP") )
		{
			hbuf = OpenBuf (filename)
			if(hbuf != 0)
			{
				SetCurrentBuf(hbuf)
				auto_insert_trace_info_in_buffer()
			}
		}
		//自动保存打开文件，可根据需要打开
/*        if( IsBufDirty (hbuf) )
		{
			SaveBuf (hbuf)
		}
		CloseBuf(hbuf)*/
		ifile = ifile + 1
	}
}

macro remove_trace_info()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	hbuf = GetWndBuf(hwnd)
	if(hbuf == hNil)
	   stop
	symbolname = GetCurSymbol()
	symbol = GetSymbolLocationFromLn(hbuf, sel.lnFirst)
//    symbol = GetSymbolLocation (symbolname)
	nLineEnd = symbol.lnLim
	curr_Entry = "DebugTrace(\"\\r\\n |@symbolname@() entry--- \");"
	curr_Exit = "DebugTrace(\"\\r\\n |@symbolname@() exit---:"
	ln = symbol.lnName
	fIsEntry = 0
	while(ln < nLineEnd)
	{
		retract_line = GetBufLine(hbuf, ln)

		/*剔除其中的注释语句*/
		RetVal = trim_string(retract_line)
		if(fIsEntry == 0)
		{
			ret = string_cmp(retract_line,curr_Entry)
			if(ret != 0xffffffff)
			{
				DelBufLine(hbuf,ln)
				nLineEnd = nLineEnd - 1
				fIsEntry = 1
				ln = ln + 1
				continue
			}
		}
		ret = string_cmp(retract_line,curr_Exit)
		if(ret != 0xffffffff)
		{
			DelBufLine(hbuf,ln)
			nLineEnd = nLineEnd - 1
		}
		ln = ln + 1
	}
}

macro remove_curr_buffer_trace_info()
{
	hbuf = GetCurrentBuf()
	isymMax = GetBufSymCount(hbuf)
	isym = 0
	while (isym < isymMax)
	{
		isLastLine = 0
		symbol = GetBufSymLocation(hbuf, isym)
		fIsEnd = 1
		if(strlen(symbol) > 0)
		{
			if(symbol.Type == "Class Placeholder")
			{
				hsyml = SymbolChildren(symbol)
				cchild = SymListCount(hsyml)
				ichild = 0
				while (ichild < cchild)
				{
					hsyml = SymbolChildren(symbol)
					childsym = SymListItem(hsyml, ichild)
					SetBufIns(hbuf,childsym.lnName,0)
					remove_trace_info()
					ichild = ichild + 1
				}
				SymListFree(hsyml)
			}
			else if( ( symbol.Type == "Function") ||  (symbol.Type == "Method") )
			{
				SetBufIns(hbuf,symbol.lnName,0)
				remove_trace_info()
			}
		}
		isym = isym + 1
	}
}

macro remove_prj_trace_info()
{
	hprj = GetCurrentProj()
	ifileMax = GetProjFileCount (hprj)
	ifile = 0
	while (ifile < ifileMax)
	{
		filename = GetProjFileName (hprj, ifile)
		hbuf = OpenBuf (filename)
		if(hbuf != 0)
		{
			SetCurrentBuf(hbuf)
			remove_curr_buffer_trace_info()
		}
		//自动保存打开文件，可根据需要打开
		/*
		if( IsBufDirty (hbuf) )
		{
			SaveBuf (hbuf)
		}
		CloseBuf(hbuf)
		*/
		ifile = ifile + 1
	}
}

/*
获取头文件类型后缀名种类与数量
*/
function get_header_filename_extension()
{
	h_buf = NewBuf("extension")
	if (h_buf == hNil)
		stop
	ClearBuf(h_buf)
	AppendBufLine(h_buf, ".h")
	AppendBufLine(h_buf, ".hpp")
	num = GetBufLineCount(h_buf)
	hxx = nil
	hxx.handle = h_buf
	hxx.num = num
	return hxx
}

/*
获取源文件类型后缀名种类与数量
*/
function get_source_filename_extension()
{
	h_buf = NewBuf("extension")
	if (h_buf == hNil)
		stop
	ClearBuf(h_buf)
	AppendBufLine(h_buf, ".c")
	AppendBufLine(h_buf, ".cpp")
	AppendBufLine(h_buf, ".cc")
	AppendBufLine(h_buf, ".cx")
	AppendBufLine(h_buf, ".cxx")
	num = GetBufLineCount(h_buf)
	cxx = nil
	cxx.handle = h_buf
	cxx.num = num
	return cxx
}

/*
获取当前文件的类型
返回值：
	unknown：未知; hxx：头文件; cxx：源文件
*/
function get_curr_file_type()
{
	index = 0
	file_type = unknown
	open_file = get_curr_open_file_absolute_path()
	parse_file_path_name_extension(open_file)
	extension = get_header_filename_extension()
	num = extension.num
	handle = extension.handle
	while(index < num)
	{
		str = GetBufLine(handle, index)
		ret = is_file_type(open_file, str)
		if(True == ret)
		{
			file_type = hxx
			return file_type
		}
		index++
	}
	
	index = 0
	extension = get_source_filename_extension()
	num = extension.num
	handle = extension.handle
	while(index < num)
	{
		str = GetBufLine(handle, index)
		ret = is_file_type(open_file, str)
		if(True == ret)
		{
			file_type = cxx
			return file_type
		}
		index++
	}

	return file_type
}

macro get_function_list(hbuf,hnewbuf)
{
	isymMax = GetBufSymCount (hbuf)
	isym = 0
	//依次取出全部的但前buf符号表中的全部符号
	while (isym < isymMax)
	{
		symbol = GetBufSymLocation(hbuf, isym)
		if(symbol.Type == "Class Placeholder")
		{
			hsyml = SymbolChildren(symbol)
			cchild = SymListCount(hsyml)
			ichild = 0
			while (ichild < cchild)
			{
				childsym = SymListItem(hsyml, ichild)
				AppendBufLine(hnewbuf,childsym.symbol)
				ichild = ichild + 1
			}
			SymListFree(hsyml)
		}
		if(strlen(symbol) > 0)
		{
			if( (symbol.Type == "Method") ||
				(symbol.Type == "Function") || ("Editor Macro" == symbol.Type) )
			{
				//取出类型是函数和宏的符号
				symname = symbol.Symbol
				//将符号插入到新buf中这样做是为了兼容V2.1
				AppendBufLine(hnewbuf,symname)
			}
		}
		isym = isym + 1
	}
}

macro comment_content (hbuf,ln,curr_PreStr,content_str,isEnd)
{
	curr_LeftBlank = curr_PreStr
	iLen = strlen(curr_PreStr)
	k = 0
	while(k < iLen)
	{
		curr_LeftBlank[k] = " ";
		k = k + 1;
	}

	hNewBuf = newbuf("clip")
	if(hNewBuf == hNil)
		return
	SetCurrentBuf(hNewBuf)
	PasteBufLine (hNewBuf, 0)
	lnMax = GetBufLineCount( hNewBuf )
	curr_Tmp = trim_string(content_str)

	//判断如果剪贴板是0行时对于有些版本会有问题，要排除掉
	if(lnMax != 0)
	{
		retract_line = GetBufLine(hNewBuf , 0)
		ret = string_cmp(retract_line,curr_Tmp)
		if(ret == 0)
		{
			/*如果输入窗输入的内容是剪贴板的一部分说明是剪贴过来的取剪贴板中的内容*/
			content_str = trim_string(retract_line)
		}
		else
		{
			lnMax = 1
		}
	}
	else
	{
		lnMax = 1
	}
	curr_Ret = ""
	nIdx = 0
	while ( nIdx < lnMax)
	{
		if(nIdx != 0)
		{
			retract_line = GetBufLine(hNewBuf , nIdx)
			content_str = trim_left(retract_line)
			curr_PreStr = curr_LeftBlank
		}
		iLen = strlen (content_str)
		curr_Tmp = cat(curr_PreStr,"#");
		if( (iLen == 0) && (nIdx == (lnMax - 1))
		{
			insert_line_string( ln, "@curr_Tmp@")
		}
		else
		{
			i = 0
			//以每行75个字符处理
			while  (iLen - i > 75 - k )
			{
				j = 0
				while(j < 75 - k)
				{
					iNum = content_str[i + j]
					if( AsciiFromChar (iNum)  > 160 )
					{
						j = j + 2
					}
					else
					{
						j = j + 1
					}
					if( (j > 70 - k) && (content_str[i + j] == " ") )
					{
						break
					}
				}
				if( (content_str[i + j] != " " ) )
				{
					n = 0;
					iNum = content_str[i + j + n]
					//如果是中文字符只能成对处理
					while( (iNum != " " ) && (AsciiFromChar (iNum)  < 160))
					{
						n = n + 1
						if((n >= 3) ||(i + j + n >= iLen))
							 break;
						iNum = content_str[i + j + n]
					}
					if(n < 3)
					{
						//分段后只有小于3个的字符留在下段则将其以上去
						j = j + n
						temp1 = strmid(content_str,i,i+j)
						temp1 = cat(curr_PreStr,temp1)
					}
					else
					{
						//大于3个字符的加连字符分段
						temp1 = strmid(content_str,i,i+j)
						temp1 = cat(curr_PreStr,temp1)
						if(temp1[strlen(temp1)-1] != "-")
						{
							temp1 = cat(temp1,"-")
						}
					}
				}
				else
				{
					temp1 = strmid(content_str,i,i+j)
					temp1 = cat(curr_PreStr,temp1)
				}
				insert_line_string( ln, "@temp1@")
				ln = ln + 1
				curr_PreStr = curr_LeftBlank
				i = i + j
				while(content_str[i] == " ")
				{
					i = i + 1
				}
			}
			temp1 = strmid(content_str,i,iLen)
			temp1 = cat(curr_PreStr,temp1)
			if((isEnd == 1) && (nIdx == (lnMax - 1))
			{
				temp1 = cat(temp1," */")
			}
			insert_line_string( ln, "@temp1@")
		}
		ln = ln + 1
		nIdx = nIdx + 1
	}
	closebuf(hNewBuf)
	return ln - 1
}

macro format_line()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	if(sel.ichFirst > 70)
	{
		Msg("选择太靠右了")
		stop
	}
	hbuf = GetWndBuf(hwnd)
	// get line the selection (insertion point) is on
	curr_line = GetBufLine(hbuf, sel.lnFirst);
	lineLen = strlen(curr_line)
	temp_left = strmid(curr_line,0,sel.ichFirst)
	content_str = strmid(curr_line,sel.ichFirst,lineLen)
	DelBufLine(hbuf, sel.lnFirst)
	comment_content(hbuf,sel.lnFirst,temp_left,content_str,0)

}

macro create_blank_string(nBlankCount)
{
	local_blank=""
	nIdx = 0
	while(nIdx < nBlankCount)
	{
		local_blank = cat(local_blank," ")
		nIdx = nIdx + 1
	}
	return local_blank
}

/*
剔除左边多余的空格和tab
*/
macro trim_left(retract_line)
{
	nLen = strlen(retract_line)
	if(nLen == 0)
	{
		return retract_line
	}
	nIdx = 0
	while( nIdx < nLen )
	{
		if( ( retract_line[nIdx] != " ") && (retract_line[nIdx] != "\t") )
		{
			break
		}
		nIdx = nIdx + 1
	}
	return strmid(retract_line,nIdx,nLen)
}

/*
剔除右边多余的空格和tab
*/
macro trim_right(retract_line)
{
	nLen = strlen(retract_line)
	if(nLen == 0)
	{
		return retract_line
	}
	nIdx = nLen
	while( nIdx > 0 )
	{
		nIdx = nIdx - 1
		if( ( retract_line[nIdx] != " ") && (retract_line[nIdx] != "\t") )
		{
			break
		}
	}
	return strmid(retract_line,0,nIdx+1)
}

/*
剔除两边多余的空格和tab
*/
macro trim_string(retract_line)
{
	retract_line = trim_left(retract_line)
	retract_line = trim_right(retract_line)
	return retract_line
}

macro get_function_def(hbuf,symbol)
{
	ln = symbol.lnName
	curr_Func = ""
	if(strlen(symbol) == 0)
	{
		return curr_Func
	}
	fIsEnd = 1

	while(ln < symbol.lnLim)
	{
		retract_line = GetBufLine (hbuf, ln)
		//去掉被注释掉的内容
		RetVal = skip_comment_from_string(retract_line,fIsEnd)
		retract_line = RetVal.content_str
		retract_line = trim_string(retract_line)
		fIsEnd = RetVal.fIsEnd
		//如果是{表示函数参数头结束了
		ret = string_cmp(retract_line,"{")
		if(ret != 0xffffffff)
		{
			retract_line = strmid(retract_line,0,ret)
			curr_Func = cat(curr_Func,retract_line)
			break
		}
		curr_Func = cat(curr_Func,retract_line)
		ln = ln + 1
	}
	return curr_Func
}

macro get_word_form_string(hbuf,retract_line,nBeg,nEnd,chBeg,chSeparator,chEnd)
{
	if((nEnd > strlen(retract_line) || (nBeg > nEnd))
	{
		return 0
	}
	nMaxLen = 0
	nIdx = nBeg
	//先定位到开始字符标记处
	while(nIdx < nEnd)
	{
		if(retract_line[nIdx] == chBeg)
		{
			break
		}
		nIdx = nIdx + 1
	}
	nBegWord = nIdx + 1

	//用于检测chBeg和chEnd的配对情况
	iCount = 0

	nEndWord = 0
	//以分隔符为标记进行搜索
	while(nIdx < nEnd)
	{
		if(retract_line[nIdx] == chSeparator)
		{
			word = strmid(retract_line,nBegWord,nIdx)
			word = trim_string(word)
			nLen = strlen(word)
			if(nMaxLen < nLen)
			{
				nMaxLen = nLen
			}
			AppendBufLine(hbuf,word)
			nBegWord = nIdx + 1
		}
		if(retract_line[nIdx] == chBeg)
		{
			iCount = iCount + 1
		}
		if(retract_line[nIdx] == chEnd)
		{
			iCount = iCount - 1
			nEndWord = nIdx
			if( iCount == 0 )
			{
				break
			}
		}
		nIdx = nIdx + 1
	}
	if(nEndWord > nBegWord)
	{
		word = strmid(retract_line,nBegWord,nEndWord)
		word = trim_string(word)
		nLen = strlen(word)
		if(nMaxLen < nLen)
		{
			nMaxLen = nLen
		}
		AppendBufLine(hbuf,word)
	}
	return nMaxLen
}

/*
函数说明信息头
*/
macro function_head_comment(hbuf, ln, curr_Func, newFunc)
{
	have_parameter = False
	
	if(newFunc != 1)
	{
		symbol = GetSymbolLocationFromLn(hbuf, ln)
		if(strlen(symbol) > 0)
		{
			hTmpBuf = NewBuf("Tempbuf")
			if(hTmpBuf == hNil)
			{
				stop
			}
			//将文件参数头整理成一行并去掉了注释
			retract_line = get_function_def(hbuf, symbol)
			iBegin = symbol.ichName
			//取出返回值定义
			curr_Temp = strmid(retract_line,0,iBegin)
			curr_Temp = trim_string(curr_Temp)
			return_type =  get_first_word(curr_Temp)
			if(symbol.Type == "Method")
			{
				curr_Temp = strmid(curr_Temp, strlen(return_type), strlen(curr_Temp))
				curr_Temp = trim_string(curr_Temp)
				if(curr_Temp == "::")
				{
					return_type = ""
				}
			}
			if(toupper (return_type) == "MACRO")
			{
				//对于宏返回值特殊处理
				return_type = ""
			}
			//从函数头分离出函数参数
			parameter_len_max = get_word_form_string(hTmpBuf, retract_line, iBegin, strlen(retract_line), "(", "," , ")")
			parameter_sum = GetBufLineCount(hTmpBuf)
			ln = symbol.lnFirst
			SetBufIns (hbuf, ln, 0)
		}
	}
	else
	{
		parameter_sum = 0
		retract_line = ""
		return_type = ""
	}
	
	insert_multiline_comments_begin(ln)
	is_english = test_language_is_english()
	if(True == is_english)
	{
		nothing_str = "None"
		func_name_str =            " Prototype   "
		func_description_str =     " Description "
		input_parameter_str =      " Input       "
		output_parameter_str =     " Output      "
		ret_str =                  " Return Value"
		
		modification_history_str = " History        "
		date_str =                 "  1.Data        "
		autor_str =                "    Author      "
		modification_details_str = "    Modification"
		new_function_str =         "Created function."
		input_function_msg =       "Please input the function description."
		input_parameter_msg =      "Please input parameter."
		return_value_type_msg =    "Please input return value type."
	}
	else
	{
		nothing_str = "无"
		func_name_str =            " 函 数 名   "
		func_description_str =     " 功能描述"
		input_parameter_str =      " 输入参数    "
		output_parameter_str =     " 输出参数    "
		ret_str =                  " 返 回 值"
		
		modification_history_str = " 历史记录    "
		date_str =                 "  1. 日期"
		autor_str =                "     作者"
		modification_details_str = "     修改"
		new_function_str =         "生成函数"
		input_function_msg =       "请输入函数功能描述的内容."
		input_parameter_msg =      "请输入函数参数名."
		return_value_type_msg =    "请输入返回值类型."
	}

	temp_str = "#"
	if( strlen(curr_Func) > 0 )
	{
		temp_str = curr_Func
	}
	insert_line_string(ln+1, "@func_name_str@: @temp_str@")
	
	oldln = ln
	insert_line_string(ln+2, "@func_description_str@: ")
	curr_Ins = "@input_parameter_str@: "
	row_offet = strlen(curr_Ins)
	if(false == is_english)
	{
		row_offet = 4
	}

	if(newFunc != True)
	{
		//对于已经存在的函数插入函数参数
		i = 0
		while ( i < parameter_sum)
		{
			parameter = GetBufLine(hTmpBuf, i)
			para_len = strlen(parameter);
			completion_blank_num = 1//parameter_len_max - para_len + 1 
			fill_spaces = create_blank_string(completion_blank_num)
			curr_Tmp = cat(parameter, fill_spaces)
			ln = ln + 1
			curr_Tmp = cat(curr_Ins, curr_Tmp)
			insert_line_string(ln+2, curr_Tmp)
			have_parameter = True
			curr_Ins = create_blank_string(row_offet)
			i++
		}
		closebuf(hTmpBuf)
	}
	
	if(False == have_parameter)
	{
		ln = ln + 1
		insert_line_string(ln+2, "@input_parameter_str@: @nothing_str@")
	}
	insert_line_string(ln+3, "@output_parameter_str@: @nothing_str@")
	insert_line_string(ln+4, "@ret_str@: @return_type@") 
	insert_line_string(ln+5, " ");
	insert_line_string(ln+6, "@modification_history_str@:")
	curr_Time = get_system_time_date()
	insert_line_string( ln+7, "@date_str@:@curr_Time@")

	author_name = get_curr_autor_name()
	temp_str = "#"
	if( strlen(author_name) > 0 )
	{
		temp_str = author_name
	}
	insert_line_string(ln+8, "@autor_str@: @temp_str@")
	insert_line_string(ln+9, "@modification_details_str@: @new_function_str@")
 
	insert_multiline_comments_end(ln+10)
	
	if ((newFunc == 1) && (strlen(curr_Func)>0))
	{
		insert_line_string(ln+11, "int32_t @curr_Func@( # )")
		insert_line_string(ln+12, "{");
		insert_line_string(ln+13, "\t#");
		insert_line_string(ln+14, "}");
		search_forward()
	}
	
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	sel.ichFirst = 0
	sel.ichLim = sel.ichFirst
	sel.lnFirst = ln + 11
	sel.lnLast = ln + 11
	content_str = Ask(input_function_msg)
	setWndSel(hwnd,sel)
	DelBufLine(hbuf,oldln + 2)

	//显示输入的功能描述内容
	newln = comment_content(hbuf,oldln+2,"@func_description_str@: ",content_str,0) - 2
	ln = ln + newln - oldln
	if ((newFunc == 1) && (strlen(curr_Func)>0))
	{
		isFirstParam = 1

		//提示输入新函数的返回值
		return_type = Ask(return_value_type_msg)
		if(strlen(return_type) > 0)
		{
			PutBufLine(hbuf, ln+1, "@ret_str@: @return_type@")
			PutBufLine(hbuf, ln+11, "@return_type@ @curr_Func@(   )")
			SetbufIns(hbuf, ln+11, strlen(return_type)+strlen(curr_Func) + 3
		}
		curr_FuncDef = ""
		sel.ichFirst = strlen(curr_Func)+strlen(return_type) + 3
		sel.ichLim = sel.ichFirst + 1
		//循环输入参数
		while (1)
		{
			curr_Param = ask(input_parameter_msg)
			curr_Param = trim_string(curr_Param)
			curr_Tmp = cat(curr_Ins, curr_Param)
			curr_Param = cat(curr_FuncDef, curr_Param)
			sel.lnFirst = ln + 11
			sel.lnLast = ln + 11
			setWndSel(hwnd,sel)
			sel.ichFirst = sel.ichFirst + strlen(curr_Param)
			sel.ichLim = sel.ichFirst
			oldsel = sel
			if(isFirstParam == 1)
			{
				PutBufLine(hbuf, ln + 2, "@curr_Tmp@")
				isFirstParam = 0
			}
			else
			{
				ln = ln + 1
				insert_line_string( ln + 2, "@curr_Tmp@")
				oldsel.lnFirst = ln + 11
				oldsel.lnLast = ln + 11
			}
			SetBufSelText(hbuf, curr_Param)
			curr_Ins = "         "
			curr_FuncDef = ", "
			oldsel.lnFirst = ln + 13
			oldsel.lnLast = ln + 13
			oldsel.ichFirst = 4
			oldsel.ichLim = 5
			setWndSel(hwnd, oldsel)
		}
	}
	
	return ln + 14
}

macro update_function_list()
{
	hnewbuf = newbuf("")
	if(hnewbuf == hNil)
	{
		stop
	}
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	hbuf = GetWndBuf(hwnd)
	get_function_list(hbuf,hnewbuf)
	ln = sel.lnFirst
	iHistoryCount = 1
	isLastLine = ln
	iTotalLn = GetBufLineCount (hbuf)
	while(ln < iTotalLn)
	{
		curr_line = GetBufLine(hbuf, ln);
		iLen = strlen(curr_line)
		j = 0;
		while(j < iLen)
		{
			if(curr_line[j] != " ")
				break
			j = j + 1
		}

		//以文件头说明中前有大于10个空格的为函数列表记录
		if(j > 10)
		{
			DelBufLine(hbuf, ln)
		}
		else
		{
			break
		}
		iTotalLn = GetBufLineCount (hbuf)
	}

	//插入函数列表
	insert_file_list( hbuf,hnewbuf,ln )
	closebuf(hnewbuf)
}

macro create_function_def(hbuf)
{
	ln = 0
	//获得当前没有后缀的文件名
	str = GetBufName (hbuf)
	curr_filename = get_only_filename(str)
	if(strlen(curr_filename) == 0)
	{
		temp_str = ask("请输入头文件名")
		curr_filename = get_filename_no_extension(temp_str)
		curr_Ext = get_filename_extension(curr_filename)
		curr_PreH = toupper (curr_filename)
		curr_PreH = cat("__",curr_PreH)
		curr_Ext = toupper(curr_Ext)
		curr_PreH = cat(curr_PreH,"_@curr_Ext@__")
	}
	curr_PreH = toupper (curr_filename)
	temp_str = cat(curr_filename,".h")
	curr_PreH = cat("__",curr_PreH)
	curr_PreH = cat(curr_PreH,"_H__")
	hOutbuf = NewBuf(temp_str) // create output buffer
	if (hOutbuf == 0)
		stop
	//搜索符号表取得函数名
	SetCurrentBuf(hOutbuf)
	isymMax = GetBufSymCount(hbuf)
	isym = 0
	while (isym < isymMax)
	{
		isLastLine = 0
		symbol = GetBufSymLocation(hbuf, isym)
		fIsEnd = 1
		if(strlen(symbol) > 0)
		{
			if(symbol.Type == "Class Placeholder")
			{
				hsyml = SymbolChildren(symbol)
				cchild = SymListCount(hsyml)
				ichild = 0
				curr_class_name = symbol.Symbol
				InsBufLine(hOutbuf, ln, "}")
				InsBufLine(hOutbuf, ln, "{")
				InsBufLine(hOutbuf, ln, "class @curr_class_name@")
				ln = ln + 2
				while (ichild < cchild)
				{
					childsym = SymListItem(hsyml, ichild)
					childsym.Symbol = curr_class_name
					ln = create_class_prototype(hbuf, ln, childsym)
					ichild = ichild + 1
				}
				SymListFree(hsyml)
				InsBufLine(hOutbuf, ln + 1, "")
				ln = ln + 2
			}
			else if( symbol.Type == "Function" )
			{
				ln = create_func_proc_type(hbuf,ln,"extern",symbol)
			}
			else if( symbol.Type == "Method" )
			{
				retract_line = GetBufline(hbuf, symbol.lnName)
				curr_class_name = get_left_word(retract_line, symbol.ichName)
				symbol.Symbol = curr_class_name
				ln = create_class_prototype(hbuf, ln, symbol)
			}

		}
		isym = isym + 1
	}
	
	insert_cplusplus(hOutbuf, 0)
	head_if_def_str(curr_PreH)
	
	content_str = get_file_name(GetBufName (hbuf))
	is_english = test_language_is_english()
	if(False == is_english)
	{
		content_str = cat(content_str, " 的头文件")
	}
	else
	{
		content_str = cat(content_str, " header file")
	}
	insert_file_header(hOutbuf, 0, content_str)//插入文件头说明
}

macro get_left_word(retract_line,ichRight)
{
	if(ich == 0)
	{
		return ""
	}
	ich = ichRight
	while(ich > 0)
	{
		if( (retract_line[ich] == " ") || (retract_line[ich] == "\t")
			|| ( retract_line[ich] == ":") || (retract_line[ich] == "."))
		{
			ich = ich - 1
			ichRight = ich
		}
		else
		{
			break
		}
	}
	while(ich > 0)
	{
		if(retract_line[ich] == " ")
		{
			ich = ich + 1
			break
		}
		ich = ich - 1
	}
	return strmid(retract_line,ich,ichRight)
}

macro create_class_prototype(hbuf,ln,symbol)
{
	isLastLine = 0
	fIsEnd = 1
	hOutbuf = GetCurrentBuf()
	retract_line = GetBufLine (hbuf, symbol.lnName)
	sline = symbol.lnFirst
	curr_ClassName = symbol.Symbol
	ret = string_cmp(retract_line,curr_ClassName)
	if(ret == 0xffffffff)
	{
		return ln
	}
	curr_Pre = strmid(retract_line,0,ret)
	retract_line = strmid(retract_line,symbol.ichName,strlen(retract_line))
	retract_line = cat(curr_Pre,retract_line)
	//去掉注释的干扰
	RetVal = skip_comment_from_string(retract_line,fIsEnd)
	fIsEnd = RetVal.fIsEnd
	curr_New = RetVal.content_str
	retract_line = cat("    ", retract_line)
	curr_New = cat("    ", curr_New)
	while((isLastLine == 0) && (sline < symbol.lnLim))
	{
		i = 0
		j = 0
		iLen = strlen(curr_New)
		while(i < iLen)
		{
			if(curr_New[i]=="(")
			{
			   j = j + 1;
			}
			else if(curr_New[i]==")")
			{
				j = j - 1;
				if(j <= 0)
				{
					//函数参数头结束
					isLastLine = 1
					//去掉最后多余的字符
					retract_line = strmid(retract_line,0,i+1);
					retract_line = cat(retract_line,";")
					break
				}
			}
			i = i + 1
		}
		InsBufLine(hOutbuf, ln, "@retract_line@")
		ln = ln + 1
		sline = sline + 1
		if(isLastLine != 1)
		{
			//函数参数头还没有结束再取一行
			retract_line = GetBufLine (hbuf, sline)
			//去掉注释的干扰
			RetVal = skip_comment_from_string(retract_line,fIsEnd)
			curr_New = RetVal.content_str
			fIsEnd = RetVal.fIsEnd
		}
	}
	return ln
}

macro create_func_proc_type(hbuf, ln, curr_Type, symbol)
{
	isLastLine = 0
	hOutbuf = GetCurrentBuf()
	retract_line = GetBufLine (hbuf,symbol.lnName)
	//去掉注释的干扰
	RetVal = skip_comment_from_string(retract_line,fIsEnd)
	curr_New = RetVal.content_str
	fIsEnd = RetVal.fIsEnd
	retract_line = cat("@curr_Type@ ",retract_line)
	curr_New = cat("@curr_Type@ ",curr_New)
	sline = symbol.lnFirst
	while((isLastLine == 0) && (sline < symbol.lnLim))
	{
		i = 0
		j = 0
		iLen = strlen(curr_New)
		while(i < iLen)
		{
			if(curr_New[i]=="(")
			{
				j = j + 1;
			}
			else if(curr_New[i]==")")
			{
				j = j - 1;
				if(j <= 0)
				{
					//函数参数头结束
					isLastLine = 1
					//去掉最后多余的字符
					retract_line = strmid(retract_line,0,i+1);
					retract_line = cat(retract_line,";")
					break
				}
			}
			i = i + 1
		}
		InsBufLine(hOutbuf, ln, "@retract_line@")
		ln = ln + 1
		sline = sline + 1
		if(isLastLine != 1)
		{
			//函数参数头还没有结束再取一行
			retract_line = GetBufLine (hbuf, sline)
			retract_line = cat("         ",retract_line)
			//去掉注释的干扰
			RetVal = skip_comment_from_string(retract_line,fIsEnd)
			curr_New = RetVal.content_str
			fIsEnd = RetVal.fIsEnd
		}
	}
	return ln
}

macro create_new_header_file()
{
	hbuf = GetCurrentBuf()
	
	isymMax = GetBufSymCount(hbuf)
	isym = 0
	ln = 0
	//获得当前没有后缀的文件名
	temp_str = ask("Please input header file name")
	file_name = get_filename_no_extension(temp_str)
	curr_Ext = get_filename_extension(temp_str)
	curr_PreH = toupper(file_name)
	curr_PreH = cat("__",curr_PreH)
	curr_Ext = toupper(curr_Ext)
	curr_PreH = cat(curr_PreH,"_@curr_Ext@__")
	hOutbuf = NewBuf(temp_str) // create output buffer
	if (hOutbuf == 0)
		stop

	SetCurrentBuf(hOutbuf)
	insert_cplusplus(hOutbuf,0)
	head_if_def_str(curr_PreH)
	
	content_str = get_file_name(GetBufName (hbuf))
	is_english = test_language_is_english()
	if(True == is_english)
	{
		content_str = cat(content_str, " header file")
	}
	else
	{
		content_str = cat(content_str, " 的头文件")
	}
	insert_file_header(hOutbuf, 0, content_str)//插入文件头说明

	lnMax = GetBufLineCount(hOutbuf)
	if(lnMax > 9)
	{
		ln = lnMax - 9
	}
	else
	{
		return
	}
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	sel.lnFirst = ln
	sel.ichFirst = 0
	sel.ichLim = 0
	SetBufIns(hOutbuf,ln,0)
	curr_Type = Ask ("Please prototype type : extern or static")
	//搜索符号表取得函数名
	while (isym < isymMax)
	{
		isLastLine = 0
		symbol = GetBufSymLocation(hbuf, isym)
		fIsEnd = 1
		if(strlen(symbol) > 0)
		{
			if(symbol.Type == "Class Placeholder")
			{
				hsyml = SymbolChildren(symbol)
				cchild = SymListCount(hsyml)
				ichild = 0
				curr_ClassName = symbol.Symbol
				InsBufLine(hOutbuf, ln, "}")
				InsBufLine(hOutbuf, ln, "{")
				InsBufLine(hOutbuf, ln, "class @curr_ClassName@")
				ln = ln + 2
				while (ichild < cchild)
				{
					childsym = SymListItem(hsyml, ichild)
					childsym.Symbol = curr_ClassName
					ln = create_class_prototype(hbuf,ln,childsym)
					ichild = ichild + 1
				}
				SymListFree(hsyml)
				InsBufLine(hOutbuf, ln + 1, "")
				ln = ln + 2
			}
			else if( symbol.Type == "Function" )
			{
				ln = create_func_proc_type(hbuf,ln,curr_Type,symbol)
			}
			else if( symbol.Type == "Method" )
			{
				retract_line = GetBufline(hbuf,symbol.lnName)
				curr_ClassName = get_left_word(retract_line,symbol.ichName)
				symbol.Symbol = curr_ClassName
				ln = create_class_prototype(hbuf,ln,symbol)
			}
		}
		isym = isym + 1
	}
	sel.lnLast = ln
	SetWndSel(hwnd,sel)
}

macro create_header_file()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	hbuf = GetWndBuf(hwnd)

	create_function_def(hbuf)
}

macro create_function_header()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	sel = GetWndSel(hwnd)
	sel_column_num = sel.lnFirst
	hbuf = GetWndBuf(hwnd)
	
	nVer = get_version()
	end_column_num = GetBufLineCount(hbuf)
	if(sel_column_num != end_column_num)
	{
		//对于2.1版的si如果是非法symbol就会中断执行，故该为以后一行  是否有‘(’来判断是否是新函数
		next_line = GetBufLine(hbuf, sel_column_num)
		if( (string_cmp(next_line,"(") != 0xffffffff) || (nVer != 2 ))
		{
			symbol = GetCurSymbol()
			if(strlen(symbol) != 0)
			{
				function_head_comment(hbuf, sel_column_num, symbol, False)
				return
			}
		}
	}
	
	is_english = test_language_is_english()
	if(True == is_english)
	{
		function_name = Ask("Please input function name")
	}
	else
	{
		function_name = Ask("请输入函数名称:")
	}
	
	function_head_comment(hbuf, sel_column_num, function_name, True)
}

macro get_word_left_of_ich(ich, temp_str)
{
	wordinfo = "" // create a "wordinfo" structure

	chTab = CharFromAscii(9)

	// scan backwords over white space, if any
	ich = ich - 1;
	if (ich >= 0)
		while (temp_str[ich] == " " || temp_str[ich] == chTab)
		{
			ich = ich - 1;
			if (ich < 0)
				break;
		}

	// scan backwords to start of word
	ichLim = ich + 1;
	asciiA = AsciiFromChar("A")
	asciiZ = AsciiFromChar("Z")
	while (ich >= 0)
	{
		ch = toupper(temp_str[ich])
		asciiCh = AsciiFromChar(ch)

/*
		if ((asciiCh < asciiA || asciiCh > asciiZ)
			 && !IsNumber(ch) && (ch != "#") )
			break // stop at first non-identifier character
*/
		//只提取字符和# { / *作为命令
		if ((asciiCh < asciiA || asciiCh > asciiZ)
			&& !IsNumber(ch)
			&& ( ch != "#" && ch != "{" && ch != "/" && ch != "*"))
			break;

		ich = ich - 1;
	}

	ich = ich + 1
	wordinfo.word = strmid(temp_str, ich, ichLim)
	wordinfo.ich = ich
	wordinfo.ichLim = ichLim;

	return wordinfo
}

macro replace_buffer_tab()
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	hbuf = GetWndBuf(hwnd)
	iTotalLn = GetBufLineCount (hbuf)
	nBlank = Ask("一个Tab替换几个空格")
	if(nBlank == 0)
	{
		nBlank = 4
	}
	local_blank = create_blank_string(nBlank)
	replace_in_buffer(hbuf, "\t", local_blank, 0, iTotalLn, 1, 0, 0, 1)
}

macro replace_tab_in_proj()
{
	hprj = GetCurrentProj()
	ifileMax = GetProjFileCount (hprj)
	nBlank = Ask("一个Tab替换几个空格")
	if(nBlank == 0)
	{
		nBlank = 4
	}
	local_blank = create_blank_string(nBlank)

	ifile = 0
	while (ifile < ifileMax)
	{
		filename = GetProjFileName (hprj, ifile)
		hbuf = OpenBuf (filename)
		if(hbuf != 0)
		{
			iTotalLn = GetBufLineCount (hbuf)
			replace_in_buffer(hbuf,"\t",local_blank,0, iTotalLn, 1, 0, 0, 1)
		}
		if( IsBufDirty (hbuf) )
		{
			SaveBuf (hbuf)
		}
		CloseBuf(hbuf)
		ifile = ifile + 1
	}
}

macro replace_in_buffer(hbuf,chOld,chNew,nBeg,nEnd,fMatchCase, fRegExp, fWholeWordsOnly, fConfirm)
{
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop
	hbuf = GetWndBuf(hwnd)
	sel = GetWndSel(hwnd)
	sel.ichLim = 0
	sel.lnLast = 0
	sel.ichFirst = sel.ichLim
	sel.lnFirst = sel.lnLast
	SetWndSel(hwnd, sel)
	LoadSearchPattern(chOld, 0, 0, 0);
	while(1)
	{
		Search_Forward
		selNew = GetWndSel(hwnd)
		if(sel == selNew)
		{
			break
		}
		SetBufSelText(hbuf, chNew)
		selNew.ichLim = selNew.ichFirst
		SetWndSel(hwnd, selNew)
		sel = selNew
	}
}

macro get_left_blank(retract_line)
{
	nIdx = 0
	nEndIdx = strlen(retract_line)
	while( nIdx < nEndIdx )
	{
		if( (retract_line[nIdx] !=" ") && (retract_line[nIdx] !="\t") )
		{
			break;
		}
		nIdx = nIdx + 1
	}
	return nIdx
}

macro expand_brace_little()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	if( (sel.lnFirst == sel.lnLast)
		&& (sel.ichFirst == sel.ichLim) )
	{
		SetBufSelText (hbuf, "(  )")
		SetBufIns (hbuf, sel.lnFirst, sel.ichFirst + 2)
	}
	else
	{
		SetBufIns (hbuf, sel.lnFirst, sel.ichFirst)
		SetBufSelText (hbuf, "( ")
		SetBufIns (hbuf, sel.lnLast, sel.ichLim + 2)
		SetBufSelText (hbuf, " )")
	}
}

macro expand_brace_mid()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	if( (sel.lnFirst == sel.lnLast)
	&& (sel.ichFirst == sel.ichLim) )
	{
		SetBufSelText (hbuf, "[]")
		SetBufIns (hbuf, sel.lnFirst, sel.ichFirst + 1)
	}
	else
	{
		SetBufIns (hbuf, sel.lnFirst, sel.ichFirst)
		SetBufSelText (hbuf, "[")
		SetBufIns (hbuf, sel.lnLast, sel.ichLim + 1)
		SetBufSelText (hbuf, "]")
	}
}

macro expand_brace_large()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	ln = sel.lnFirst
	nlineCount = 0
	retVal = ""
	retract_line = GetBufLine( hbuf, ln )
	nLeft = get_left_blank(retract_line)
	temp_left = strmid(retract_line, 0, nLeft);

	pretty_format = get_pretty_code_left_format()
	alignment = pretty_format.alignment
	retract = pretty_format.retract
	curr_Right = ""
	curr_Mid = ""
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		//对于没有块选择的情况，直接插入{}即可
		if( nLeft == strlen(retract_line) )
		{
			SetBufSelText (hbuf, "{")
		}
		else
		{
			ln = ln + 1
			insert_line_string( ln, "@alignment@{")
			nlineCount = nlineCount + 1
		}
		insert_line_string( ln + 1, "@retract@")
		insert_line_string( ln + 2, "@alignment@}")
		nlineCount = nlineCount + 2
		SetBufIns (hbuf, ln + 1, strlen(temp_left)+4)
	}
	else
	{
		//对于有块选择的情况还得考虑将块选择区分开了

		//检查选择区内是否大括号配对，如果嫌太慢则注释掉下面的判断
		RetVal= check_block_brace(hbuf)
		if(RetVal.iCount != 0)
		{
			msg("Invalidated brace number")
			stop
		}

		//取出选中区前的内容
		curr_Old = strmid(retract_line,0,sel.ichFirst)
		if(sel.lnFirst != sel.lnLast)
		{
			//对于多行的情况
			
			//第一行的选中部分
			curr_Mid = strmid(retract_line,sel.ichFirst,strlen(retract_line))
			curr_Mid = trim_string(curr_Mid)
			curr_Last = GetBufLine(hbuf,sel.lnLast)
			if( sel.ichLim > strlen(curr_Last) )
			{
				//如果选择区长度大于改行的长度，最大取该行的长度
				retract_lineselichLim = strlen(curr_Last)
			}
			else
			{
				retract_lineselichLim = sel.ichLim
			}

			//得到最后一行选择区为的字符
			curr_Right = strmid(curr_Last,retract_lineselichLim,strlen(curr_Last))
			curr_Right = trim_string(curr_Right)
		}
		else
		{
			//对于选择只有一行的情况
			if(sel.ichLim >= strlen(retract_line))
			{
				sel.ichLim = strlen(retract_line)
			}

			//获得选中区的内容
			curr_Mid = strmid(retract_line,sel.ichFirst,sel.ichLim)
			curr_Mid = trim_string(curr_Mid)
			if( sel.ichLim > strlen(retract_line) )
			{
				 retract_lineselichLim = strlen(retract_line)
			}
			else
			{
				 retract_lineselichLim = sel.ichLim
			}

			//同样得到选中区后的内容
			curr_Right = strmid(retract_line,retract_lineselichLim,strlen(retract_line))
			curr_Right = trim_string(curr_Right)
		}
		nIdx = sel.lnFirst
		while( nIdx < sel.lnLast)
		{
			curr_line = GetBufLine(hbuf,nIdx+1)
			if( sel.ichLim > strlen(curr_line) )
			{
				retract_lineselichLim = strlen(curr_line)
			}
			else
			{
				retract_lineselichLim = sel.ichLim
			}
			curr_line = cat("    ",curr_line)
			if(nIdx == sel.lnLast - 1)
			{
				//对于最后一行应该是选中区内的内容后移四位
				curr_line = strmid(curr_line,0,retract_lineselichLim + 4)
				PutBufLine(hbuf,nIdx+1,curr_line)
			}
			else
			{
				//其它情况是整行的内容后移四位
				PutBufLine(hbuf,nIdx+1,curr_line)
			}
			nIdx = nIdx + 1
		}
		if(strlen(curr_Right) != 0)
		{
			//最后插入最后一行没有被选择的内容
			insert_line_string( sel.lnLast + 1, "@temp_left@@curr_Right@")
		}
		insert_line_string( sel.lnLast + 1, "@temp_left@}")
		nlineCount = nlineCount + 1
		if(nLeft < sel.ichFirst)
		{
			//如果选中区前的内容不是空格，则要保留该部分内容
			PutBufLine(hbuf,ln,curr_Old)
			insert_line_string( ln+1, "@temp_left@{")
			nlineCount = nlineCount + 1
			ln = ln + 1
		}
		else
		{
			//如果选中区前没有内容直接删除该行
			DelBufLine(hbuf,ln)
			insert_line_string( ln, "@temp_left@{")
		}
		if(strlen(curr_Mid) > 0)
		{
			//插入第一行选择区的内容
			insert_line_string( ln+1, "@temp_left@    @curr_Mid@")
			nlineCount = nlineCount + 1
			ln = ln + 1
		}
	}
	retVal.temp_left = temp_left
	retVal.nLineCount = nlineCount
	//返回行数和左边的空白
	return retVal
}

macro move_comment_left_blank(retract_line)
{
	nIdx  = 0
	iLen = strlen(retract_line)
	while(nIdx < iLen - 1)
	{
		if(retract_line[nIdx] == "/" && retract_line[nIdx+1] == "*")
		{
			retract_line[nIdx] = " "
			retract_line[nIdx + 1] = " "
			nIdx = nIdx + 2
			while(nIdx < iLen - 1)
			{
				if(retract_line[nIdx] != " " && retract_line[nIdx] != "\t")
				{
					retract_line[nIdx - 2] = "/"
					retract_line[nIdx - 1] = "*"
					return retract_line
				}
				nIdx = nIdx + 1
			}
		}

		if(retract_line[nIdx] == "/" && retract_line[nIdx+1] == "/")
		{
			retract_line[nIdx] = " "
			retract_line[nIdx + 1] = " "
			nIdx = nIdx + 2
			while(nIdx < iLen - 1)
			{
				if(retract_line[nIdx] != " " && retract_line[nIdx] != "\t")
				{
					retract_line[nIdx - 2] = "/"
					retract_line[nIdx - 1] = "/"
					return retract_line
				}
				nIdx = nIdx + 1
			}
		}
		nIdx = nIdx + 1
	}
	return retract_line
}

macro del_compound_statement()
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	hbuf = GetCurrentBuf()
	ln = sel.lnFirst
	retract_line = GetBufLine(hbuf,ln )
	nLeft = get_left_blank(retract_line)
	temp_left = strmid(retract_line,0,nLeft);
	Msg("@retract_line@  will be deleted !")
	fIsEnd = 1
	while(1)
	{
		RetVal = skip_comment_from_string(retract_line,fIsEnd)
		curr_Tmp = RetVal.content_str
		fIsEnd = RetVal.fIsEnd
		//查找复合语句的开始
		ret = string_cmp(curr_Tmp,"{")
		if(ret != 0xffffffff)
		{
			curr_NewLine = strmid(retract_line,ret+1,strlen(retract_line))
			curr_New = strmid(curr_Tmp,ret+1,strlen(curr_Tmp))
			curr_New = trim_string(curr_New)
			if(curr_New != "")
			{
				insert_line_string(ln + 1,"@temp_left@    @curr_NewLine@");
			}
			sel.lnFirst = ln
			sel.lnLast = ln
			sel.ichFirst = ret
			sel.ichLim = ret
			//查找对应的大括号

			//使用自己编写的代码速度太慢
			retTmp = search_compound_end(hbuf,ln,ret)
			if(retTmp.iCount == 0)
			{

				DelBufLine(hbuf,retTmp.ln)
				sel.ichFirst = 0
				sel.ichLim = 0
				DelBufLine(hbuf,ln)
				sel.lnLast = retTmp.ln - 1
				SetWndSel(hwnd,sel)
				Indent_Left
			}

			//使用Si的大括号配对方法，但V2.1时在注释嵌套时可能有误
			/*
			etWndSel(hwnd,sel)
			Block_Down
			selNew = GetWndSel(hwnd)
			if(selNew != sel)
			{
				DelBufLine(hbuf,selNew.lnFirst)
				sel.ichFirst = 0
				sel.ichLim = 0
				DelBufLine(hbuf,ln)
				sel.lnLast = selNew.lnFirst - 1
				SetWndSel(hwnd,sel)
				Indent_Left
			}
			*/
			break
		}
		
		curr_Tmp = trim_string(curr_Tmp)
		iLen = strlen(curr_Tmp)
		if(iLen != 0)
		{
			if(curr_Tmp[iLen-1] == ";")
			{
				break
			}
		}
		
		DelBufLine(hbuf,ln)
		if( ln == GetBufLineCount(hbuf ))
		{
			break
		}
		retract_line = GetBufLine(hbuf,ln)
	}
}

macro check_block_brace(hbuf)
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	ln = sel.lnFirst
	nCount = 0
	RetVal = ""
	retract_line = GetBufLine( hbuf, ln )
	if(sel.lnFirst == sel.lnLast && sel.ichFirst == sel.ichLim)
	{
		RetVal.iCount = 0
		RetVal.ich = sel.ichFirst
		return RetVal
	}
	if(sel.lnFirst == sel.lnLast && sel.ichFirst != sel.ichLim)
	{
		RetTmp = skip_comment_from_string(retract_line,fIsEnd)
		curr_Tmp = RetTmp.content_str
		RetVal = check_brace(curr_Tmp,sel.ichFirst,sel.ichLim,"{","}",0,1)
		return RetVal
	}
	if(sel.lnFirst != sel.lnLast)
	{
		fIsEnd = 1
		while(ln <= sel.lnLast)
		{
			if(ln == sel.lnFirst)
			{
				RetVal = check_brace(retract_line,sel.ichFirst,strlen(retract_line)-1,"{","}",nCount,fIsEnd)
			}
			else if(ln == sel.lnLast)
			{
				RetVal = check_brace(retract_line,0,sel.ichLim,"{","}",nCount,fIsEnd)
			}
			else
			{
				RetVal = check_brace(retract_line,0,strlen(retract_line)-1,"{","}",nCount,fIsEnd)
			}
			fIsEnd = RetVal.fIsEnd
			ln = ln + 1
			nCount = RetVal.iCount
			retract_line = GetBufLine( hbuf, ln )
		}
	}
	return RetVal
}

macro search_compound_end(hbuf,ln,ichBeg)
{
	hwnd = GetCurrentWnd()
	sel = GetWndSel(hwnd)
	ln = sel.lnFirst
	nCount = 0
	SearchVal = ""
//    retract_line = GetBufLine( hbuf, ln )
	lnMax = GetBufLineCount(hbuf)
	fIsEnd = 1
	while(ln < lnMax)
	{
		retract_line = GetBufLine( hbuf, ln )
		RetVal = check_brace(retract_line,ichBeg,strlen(retract_line)-1,"{","}",nCount,fIsEnd)
		fIsEnd = RetVal.fIsEnd
		ichBeg = 0
		nCount = RetVal.iCount

		//如果nCount=0则说明{}是配对的
		if(nCount == 0)
		{
			break
		}
		ln = ln + 1
//        retract_line = GetBufLine( hbuf, ln )
	}
	SearchVal.iCount = RetVal.iCount
	SearchVal.ich = RetVal.ich
	SearchVal.ln = ln
	return SearchVal
}

macro check_brace(retract_line, ichBeg, ichEnd, chBeg, chEnd, nCheckCount, isCommentEnd)
{
	retVal = ""
	retVal.ich = 0
	nIdx = ichBeg
	nLen = strlen(retract_line)
	if(ichEnd >= nLen)
	{
		ichEnd = nLen - 1
	}
	fIsEnd = 1
	while(nIdx <= ichEnd)
	{
		//如果是/*注释区，跳过该段
		if( (isCommentEnd == 0) || (retract_line[nIdx] == "/" && retract_line[nIdx+1] == "*"))
		{
			fIsEnd = 0
			while(nIdx <= ichEnd )
			{
				if(retract_line[nIdx] == "*" && retract_line[nIdx+1] == "/")
				{
					nIdx = nIdx + 1
					fIsEnd  = 1
					isCommentEnd = 1
					break
				}
				nIdx = nIdx + 1
			}
			if(nIdx > ichEnd)
			{
				break
			}
		}
		//如果是//注释则停止查找
		if(retract_line[nIdx] == "/" && retract_line[nIdx+1] == "/")
		{
			break
		}
		if(retract_line[nIdx] == chBeg)
		{
			nCheckCount = nCheckCount + 1
		}
		if(retract_line[nIdx] == chEnd)
		{
			nCheckCount = nCheckCount - 1
			if(nCheckCount == 0)
			{
				retVal.ich = nIdx
			}
		}
		nIdx = nIdx + 1
	}
	retVal.iCount = nCheckCount
	retVal.fIsEnd = fIsEnd
	return retVal
}

macro get_switch_var(retract_line)
{
	if( (retract_line == "{") || (retract_line == "}") )
	{
		return ""
	}
	ret = string_cmp(retract_line,"#define" )
	if(ret != 0xffffffff)
	{
		retract_line = strmid(retract_line,ret + 8,strlen(retract_line))
	}
	retract_line = trim_left(retract_line)
	nIdx = 0
	nLen = strlen(retract_line)
	while( nIdx < nLen)
	{
		if((retract_line[nIdx] == " ") || (retract_line[nIdx] == ",") || (retract_line[nIdx] == "="))
		{
			retract_line = strmid(retract_line,0,nIdx)
			return retract_line
		}
		nIdx = nIdx + 1
	}
	return retract_line
}

macro skip_comment_from_string(retract_line, isCommentEnd)
{
	RetVal = ""
	fIsEnd = 1
	nLen = strlen(retract_line)
	nIdx = 0
	while(nIdx < nLen )
	{
		//如果当前行开始还是被注释，或遇到了注释开始的变标记，注释内容改为空格?
		if( (isCommentEnd == 0) || (retract_line[nIdx] == "/" && retract_line[nIdx+1] == "*"))
		{
			fIsEnd = 0
			while(nIdx < nLen )
			{
				if(retract_line[nIdx] == "*" && retract_line[nIdx+1] == "/")
				{
					retract_line[nIdx+1] = " "
					retract_line[nIdx] = " "
					nIdx = nIdx + 1
					fIsEnd  = 1
					isCommentEnd = 1
					break
				}
				retract_line[nIdx] = " "

				//如果是倒数第二个则最后一个也肯定是在注释内
				//if(nIdx == nLen -2 )
				//{
				//	retract_line[nIdx + 1] = " "
				//}
				nIdx = nIdx + 1
			}

			//如果已经到了行尾终止搜索
			if(nIdx == nLen)
			{
				break
			}
		}

		//如果遇到的是//来注释的说明后面都为注释
		if(retract_line[nIdx] == "/" && retract_line[nIdx+1] == "/")
		{
			retract_line = strmid(retract_line,0,nIdx)
			break
		}
		nIdx = nIdx + 1
	}
	RetVal.content_str = retract_line;
	RetVal.fIsEnd = fIsEnd
	return RetVal
}

macro merge_string()
{
	hbuf = newbuf("clip")
	if(hbuf == hNil)
		return
	SetCurrentBuf(hbuf)
	PasteBufLine (hbuf, 0)

	//如果剪贴板中没有内容，则返回
	lnMax = GetBufLineCount(hbuf )
	if( lnMax == 0 )
	{
		closebuf(hbuf)
		return ""
	}
	lnLast =  0
	if(lnMax > 1)
	{
		lnLast = lnMax - 1
		 i = lnMax - 1
	}
	while ( i > 0)
	{
		retract_line = GetBufLine(hbuf , i-1)
		retract_line = trim_left(retract_line)
		nLen = strlen(retract_line)
		if(retract_line[nLen - 1] == "-")
		{
			retract_line = strmid(retract_line,0,nLen - 1)
		}
		nLen = strlen(retract_line)
		if( (retract_line[nLen - 1] != " ") && (AsciiFromChar (retract_line[nLen - 1])  <= 160))
		{
			retract_line = cat(retract_line," ")
		}
		SetBufIns (hbuf, lnLast, 0)
		SetBufSelText(hbuf,retract_line)
		i = i - 1
	}
	retract_line = GetBufLine(hbuf,lnLast)
	closebuf(hbuf)
	return retract_line
}

/*
this macro convet selected  C++ coment block to C comment block
for example:
  line "  // aaaaa "
  convert to  /* aaaaa */
*/
macro comment_cpp_to_c()
{
	hwnd = GetCurrentWnd()
	hbuf = GetCurrentBuf()
	lnFirst = GetWndSelLnFirst( hwnd )
	lnCurrent = lnFirst
	lnLast = GetWndSelLnLast( hwnd )
	ch_comment = CharFromAscii(47)
	isCommentEnd = 1
	isCommentContinue = 0
	while ( lnCurrent <= lnLast )
	{
		ich = 0
		line_str = GetBufLine(hbuf,lnCurrent)
		ilen = strlen(line_str)
		while ( ich < ilen )
		{
			if( (line_str[ich] != " ") && (line_str[ich] != "\t") )
			{
				break
			}
			ich = ich + 1
		}
		/*如果是空行，跳过该行*/
		if(ich == ilen)
		{
			lnCurrent = lnCurrent + 1
			curr_OldLine = line_str
			continue
		}
		/*如果该行只有一个字符*/
		if(ich > ilen - 2)
		{
			if( isCommentContinue == 1 )
			{
				curr_OldLine = cat(curr_OldLine,"  */")
				PutBufLine(hbuf,lnCurrent-1,curr_OldLine)
				isCommentContinue = 0
			}
			lnCurrent = lnCurrent + 1
			curr_OldLine = line_str
			continue
		}
		
		if( isCommentEnd == 1 )
		{
			/*如果不是在注释区内*/
			if(( line_str[ich]==ch_comment ) && (line_str[ich+1]==ch_comment))
			{
				/* 去掉中间嵌套的注释 */
				nIdx = ich + 2
				while ( nIdx < ilen -1 )
				{
					if( (( line_str[nIdx] == "/" ) && (line_str[nIdx+1] == "*")||
						 ( line_str[nIdx] == "*" ) && (line_str[nIdx+1] == "/") )
					{
						line_str[nIdx] = " "
						line_str[nIdx+1] = " "
					}
					nIdx = nIdx + 1
				}

				if( isCommentContinue == 1 )
				{
					/* 如果是连续的注释*/
					line_str[ich] = " "
					line_str[ich+1] = " "
				}
				else
				{
					/*如果不是连续的注释则是新注释的开始*/
					line_str[ich] = "/"
					line_str[ich+1] = "*"
				}
				if ( lnCurrent == lnLast )
				{
					/*如果是最后一行则在行尾添加结束注释符*/
					line_str = cat(line_str,"  */")
					isCommentContinue = 0
				}
				/*更新该行*/
				PutBufLine(hbuf,lnCurrent,line_str)
				isCommentContinue = 1
				curr_OldLine = line_str
				lnCurrent = lnCurrent + 1
				continue
			}
			else
			{
				/*如果该行的起始不是//注释*/
				if( isCommentContinue == 1 )
				{
					curr_OldLine = cat(curr_OldLine,"  */")
					PutBufLine(hbuf,lnCurrent-1,curr_OldLine)
					isCommentContinue = 0
				}
			}
		}
		
		while ( ich < ilen - 1 )
		{
			//如果是/*注释区，跳过该段
			if( (isCommentEnd == 0) || (line_str[ich] == "/" && line_str[ich+1] == "*"))
			{
				isCommentEnd = 0
				while(ich < ilen - 1 )
				{
					if(line_str[ich] == "*" && line_str[ich+1] == "/")
					{
						ich = ich + 1
						isCommentEnd = 1
						break
					}
					ich = ich + 1
				}
				if(ich >= ilen - 1)
				{
					break
				}
			}

			if(( line_str[ich]==ch_comment ) && (line_str[ich+1]==ch_comment))
			{
				/* 如果是//注释*/
				isCommentContinue = 1
				nIdx = ich
				//去掉期间的/* 和 */注释符以免出现注释嵌套错误
				while ( nIdx < ilen -1 )
				{
					if( (( line_str[nIdx] == "/" ) && (line_str[nIdx+1] == "*")||
						 ( line_str[nIdx] == "*" ) && (line_str[nIdx+1] == "/") )
					{
						line_str[nIdx] = " "
						line_str[nIdx+1] = " "
					}
					nIdx = nIdx + 1
				}
				line_str[ich+1] = "*"
				if( lnCurrent == lnLast )
				{
					line_str = cat(line_str,"  */")
				}
				PutBufLine(hbuf,lnCurrent,line_str)
				break
			}
			ich = ich + 1
		}
		curr_OldLine = line_str
		lnCurrent = lnCurrent + 1
	}
}

macro comment_line()
{
	hwnd = GetCurrentWnd()
	hbuf = GetCurrentBuf()
	lnFirst = GetWndSelLnFirst( hwnd )
	lnCurrent = lnFirst
	lnLast = GetWndSelLnLast( hwnd )
	lnOld = 0
	while ( lnCurrent <= lnLast )
	{
		line_str = GetBufLine(hbuf,lnCurrent)
		DelBufLine(hbuf,lnCurrent)
		nLeft = get_left_blank(line_str)
		temp_left = strmid(line_str,0,nLeft);
		line_str = trim_string(line_str)
		ilen = strlen(line_str)
		if(iLen == 0)
		{
			continue
		}
		nIdx = 0
		//去掉期间的/* 和 */注释符以免出现注释嵌套错误
		while ( nIdx < ilen -1 )
		{
			if( (( line_str[nIdx] == "/" ) && (line_str[nIdx+1] == "*")||
				 ( line_str[nIdx] == "*" ) && (line_str[nIdx+1] == "/") )
			{
				line_str[nIdx] = " "
				line_str[nIdx+1] = " "
			}
			nIdx = nIdx + 1
		}
		line_str = cat("/* ",line_str)
		lnOld = lnCurrent
		lnCurrent = comment_content(hbuf,lnCurrent,temp_left,line_str,1)
		lnLast = lnCurrent - lnOld + lnLast
		lnCurrent = lnCurrent + 1
	}
}

macro comment_cvt_line(lnCurrent, isCommentEnd)
{
	hbuf = GetCurrentBuf()
	line_str = GetBufLine(hbuf,lnCurrent)
	ch_comment = CharFromAscii(47)
	ich = 0
	ilen = strlen(line_str)

	fIsEnd = 1
	iIsComment = 0;

	while ( ich < ilen - 1 )
	{
		//如果是/*注释区，跳过该段
		if( (isCommentEnd == 0) || (line_str[ich] == "/" && line_str[ich+1] == "*"))
		{
			fIsEnd = 0
			while(ich < ilen - 1 )
			{
				if(line_str[ich] == "*" && line_str[ich+1] == "/")
				{
					ich = ich + 1
					fIsEnd  = 1
					isCommentEnd = 1
					break
				}
				ich = ich + 1
			}
			if(ich >= ilen - 1)
			{
				break
			}
		}
		if(( line_str[ich]==ch_comment ) && (line_str[ich+1]==ch_comment))
		{
			nIdx = ich
			while ( nIdx < ilen -1 )
			{
				if( (( line_str[nIdx] == "/" ) && (line_str[nIdx+1] == "*")||
					 ( line_str[nIdx] == "*" ) && (line_str[nIdx+1] == "/") )
				{
					line_str[nIdx] = " "
					line_str[nIdx+1] = " "
				}
				nIdx = nIdx + 1
			}
			line_str[ich+1] = "*"
			line_str = cat(line_str,"  */")
			DelBufLine(hbuf,lnCurrent)
			insert_line_string(lnCurrent,line_str)
			return fIsEnd
		}
		ich = ich + 1
	}
	return fIsEnd
}

macro head_if_def_str(temp_str)
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	hbuf = GetCurrentBuf()
	insert_line_string( lnFirst, "")
	insert_line_string( lnFirst, "#define @temp_str@")
	insert_line_string( lnFirst, "#ifndef @temp_str@")
	iTotalLn = GetBufLineCount (hbuf)
	insert_line_string( iTotalLn, "#endif /* @temp_str@ */")
	insert_line_string( iTotalLn, "")
}

/*
切换源文件和头文件
*/
macro switch_cpp_hpp()
{
	file_type = get_curr_file_type()
	if( cxx == file_type)
	{
		extension = get_header_filename_extension()
	}
	else if( hxx == file_type)
	{
		extension = get_source_filename_extension()
	}
	else
	{
		Msg("The file type is not recognizable.")
		return
	}
	num = extension.num
	handle = extension.handle
	
	file_absolute_path = get_curr_open_file_absolute_path()
	index = 0
	
	while(index < num)
	{
		str = get_filename_no_extension(file_absolute_path)
		dest_extension = GetBufLine(handle, index)
		dest_file_path = cat(str, dest_extension)
		open_handle = OpenBuf(dest_file_path)
		if( 0 != open_handle)
		{
			SetCurrentBuf(open_handle)
			break
		}
		index++
	}
}

/*
在字符串中查找最后一个与str中的某个字符匹配的字符key，返回它的位置。
搜索从字符串末尾开始。如果没找到就返回nil
*/
function find_last_of(str, key)
{
	len = strlen(str)
	pos = nil
	if(len > 0)
	{
		while(True)
		{
			len = len - 1
			if(strmid(str, len, len+1) == key)
			{
				pos = len
				break
			}
			
			if(len <= 0)
				break
		}
	}
	
	return pos
}

/*
添加文件后缀名类型
*/
macro add_file_extension(file, extension)
{
	return cat(file, extension)
}

/*
检测文件后缀名类型
*/
macro is_file_type(file, extension)
{
	end_pos = strlen(file)
	len = strlen(extension)
	start_pos = end_pos - len
	str = strmid(file, start_pos, end_pos)
	if(toupper(str) == toupper(extension))
		return True

	return False
}

