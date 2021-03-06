;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;游戏工程设定
;---------------------------------------------------------------
*start
[iscript]
//每次切换到此画面时，重载
f.setting=getConfig();
[endscript]

*window
[eval exp="drawPageBoard()"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
[nowait]
;---------------------------------------------------------------
;保存与重载按钮
;---------------------------------------------------------------
[locate x=370 y=500]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存设定]
[eval exp="drawButtonCaption('保存设定',16)"]
[locate x=650 y=500]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*放弃修改]
[eval exp="drawButtonCaption('放弃修改',16)"]
;---------------------------------------------------------------
;自定义
;---------------------------------------------------------------
[frame title="系统样式" line=2 x=15 y=15]
[line title="游戏标题" name="f.setting.title" x=30 y=35]
[line title="启动画面" name="f.setting.startfrom" type="script" x=30 y=65]

[frame title="分辨率" line=2 x=15 y=125]
[line title="宽度" name="f.setting.width" x=30 y=145]
[line title="高度" name="f.setting.height" x=30 y=175]

[frame title="选项：按钮自动排列区域" x=15 y=235 line=4]
[line title="x" name="f.setting.selbutton.left" x=30 y=255]
[line title="y" name="f.setting.selbutton.top" x=30 y=285]
[line title="宽度" name="f.setting.selbutton.width" x=30 y=315]
[line title="高度" name="f.setting.selbutton.height" x=30 y=345]

[frame title="选项：按钮图形" x=345 y=15 line=3]
[line title="一般" name="f.setting.selbutton.normal" type="pic" path="others" x=360 y=35]
[line title="选中" name="f.setting.selbutton.over" type="pic" path="others" x=360 y=65 copyfrom="f.setting.selbutton.normal"]
[line title="按下" name="f.setting.selbutton.on" type="pic" path="others" x=360 y=95 copyfrom="f.setting.selbutton.over"]

[frame title="选项：字体样式" x=345 y=155 line=5]
[line title="字号" name="f.setting.selfont.height" x=360 y=175]
[line title="一般" name="f.setting.selfont.normal" type="color" x=360 y=205]
[line title="选中" name="f.setting.selfont.over" type="color" x=360 y=235 copyfrom="f.setting.selfont.normal"]
[line title="按下" name="f.setting.selfont.on" type="color" x=360 y=265 copyfrom="f.setting.selfont.over"]
[line title="既读" name="f.setting.selfont.read" type="color" x=360 y=295 copyfrom="f.setting.selfont.on"]

[frame title="选项：音效" x=345 y=355 line=2]
[line title="选中" name="f.setting.selbutton.enterse" x=360 y=375 type="sound"]
[line title="按下" name="f.setting.selbutton.clickse" x=360 y=405 type="sound"]


[frame title="预渲染字体：其他界面" line=3 x=675 y=15]
[line title="选项按钮" name="f.setting.mapp_sel" x=690 y=35 true="f.setting.usemappfont"]
[line title="历史记录" name="f.setting.mapp_his" x=690 y=65 true="f.setting.usemappfont"]
[line title="询问窗口" name="f.setting.mapp_sys" x=690 y=95 true="f.setting.usemappfont"]


[frame title="预渲染字体：存取按钮" line=4 x=675 y=155]
[line title="档案编号" name="f.setting.mapp_num" x=690 y=175 true="f.setting.usemappfont"]
[line title="章节名称" name="f.setting.mapp_label" x=690 y=205 true="f.setting.usemappfont"]
[line title="存档日期" name="f.setting.mapp_date" x=690 y=235 true="f.setting.usemappfont"]
[line title="最近对话" name="f.setting.mapp_talk" x=690 y=265 true="f.setting.usemappfont"]

[frame title="预渲染字体：悬停信息" line=3 x=675 y=325]
[line title="章节名称" name="f.setting.mapp_over_label" x=690 y=345 true="f.setting.usemappfont"]
[line title="存档日期" name="f.setting.mapp_over_date" x=690 y=375 true="f.setting.usemappfont"]
[line title="最近对话" name="f.setting.mapp_over_talk" x=690 y=405 true="f.setting.usemappfont"]

[s]

*选择音声
[call storage="window_bgm.ks"]
[jump target=*window]

*选择文件
[call storage="window_file.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

*关闭下拉菜单
[rclick enabled="false"]
[current layer="message4"]
[er]
[layopt layer="message4" visible="false"]
[jump target=*window]

*保存设定
[commit]
[iscript]
//将“文字”->数值
f.setting.width=(int)f.setting.width;
f.setting.height=(int)f.setting.height;

//确保分辨率最小值
if (f.setting.width<800) f.setting.width=800;
if (f.setting.height<600) f.setting.height=600;

 //根据设定改变分辨率
sf.gs.width=f.setting.width;
sf.gs.height=f.setting.height;

 //保存自定义内容
 (Dictionary.saveStruct incontextof f.setting)(sf.path+"macro/"+"setting.tjs");
 //保存config.tjs内容
 saveConfig();
 
 //重写start.ks.从新标题启动
 rewriteStart(f.setting.startfrom);

[endscript]
[jump target=*window]

*放弃修改
[iscript]
//重载
f.setting=getConfig();
[endscript]
[jump target=*window]
