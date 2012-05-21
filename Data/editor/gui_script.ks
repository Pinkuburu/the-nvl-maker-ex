;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;腳本編輯器
;--------------------------------------------------
[iscript]
//默認翻到最後一頁
if (f.script.count-15>=0) f.索引行=f.script.count-15;
else f.索引行=0;

f.當前腳本行=f.索引行;
[endscript]

*window
[rclick enabled="false"]
;當前編輯中
[eval exp="f.window='script'"]
[eval exp="drawPageBoard(143)"]
;顯示工具欄
[current layer="message1"]
[er]
[iscript]
drawFrame("文件操作",2,15,15,kag.fore.layers[0],314);
drawFrame("測試",1,15,120,kag.fore.layers[0],314);
drawFrame("單行操作",2,15,355,kag.fore.layers[0],314);
drawFrame("詳細參數",10,15,465,kag.fore.layers[0],314);
drawFrame(f.scenario,25,345,15,kag.fore.layers[0],1000);
[endscript]

;文件操作
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*重載腳本 hint="放棄已經做出的修改"]
[eval exp="drawButtonCaption('重載腳本',16)"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存腳本 hint="將修改保存到腳本文件"]
[eval exp="drawButtonCaption('保存腳本',16)"]

[locate x=50 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*關閉腳本 hint="退出腳本編輯器，未作保存的修改會丟失"]
[eval exp="drawButtonCaption('關閉腳本',16)"]
[locate x=190 y=70]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*直接編輯 hint="切換到文本編輯模式（自動保存並關閉腳本編輯器）"]
[eval exp="drawButtonCaption('直接編輯',16)"]

[locate x=50 y=145]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*全局測試 hint="從標題開始測試遊戲（自動保存）"]
[eval exp="drawButtonCaption('全局測試',16)"]
[locate x=190 y=145]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存測試 hint="從本腳本開始測試遊戲（自動保存）"]
[eval exp="drawButtonCaption('事件測試',16)"]

;單行操作
[locate x=40 y=385]
[button normal="edit_button_insert" exp="insertLine()" hint="插入空白行（到上方）"]
[locate x=90 y=385]
[button normal="edit_button_delete" exp="deleteLine()" hint="刪除"]

[locate x=150 y=385]
[button normal="edit_button_cut" exp="cutLine()" target=*window hint="剪切"]
[locate x=200 y=385]
[button normal="edit_button_copy" exp="tf.複製行=copyLine()" target=*window hint="複製"]
[locate x=250 y=385]
[button normal="edit_button_paste" exp="pasteLine(tf.複製行)" cond="tf.複製行!=void" hint="粘貼（到下方）"]
[button normal="edit_button_paste_disable" cond="tf.複製行==void" hint="粘貼（不可用）"]

;滾動條
[button_page x=1320 y=20 length=770]
[locate x=1320 y=36]
[button normal="edit_slider_back" interval=10 ontimer="script_scroll()"]
[image layer=2 storage="edit_slider_button" left=&"1320+(int)kag.fore.messages[1].left"]

;顯示代碼欄
[iscript]
updateScript();

//顯示代碼選擇按鈕
for (var i=0;i<35;i++)
{
     kag.tagHandlers.locate(
     %[
         "x"=>360,
         "y"=>36+21*i,
      ]
      );
      var setting=new Dictionary();
      setting.normal="edit_button_line_normal";
      setting.over="edit_button_line_over";
      setting.exp="selScript("+i+")";
      kag.tagHandlers.button(setting);
}
[endscript]
[s]
;--------------------------------------------------
*保存腳本
[iscript]
//轉換為tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
[endscript]
[jump storage="gui_script.ks" target=*window]

*直接編輯
;保存
[iscript]
//轉換為tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
[endscript]

;關閉
[eval exp="f.window=''"]
;滾動條消除
[freeimage layer=2]
[iscript]
//清除相關內容
f.索引行=void;
f.當前腳本行=void;
f.script=void;
f.腳本顯示=void;
//改回從標題啟動
rewriteStart(f.setting.startfrom);
[endscript]

;打開腳本
[eval exp="System.shellExecute(Storages.getLocalName(sf.path+'scenario/')+f.scenario)"]
[jump storage="script_main.ks"]
;--------------------------------------------------
*保存測試
[iscript]
//轉換為tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
//重寫start.ks
rewriteStart(f.scenario);
[endscript]
;啟動測試
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'project/'+sf.project+'/') + 'krkr.exe')"]
[jump storage="gui_script.ks" target=*window]

*全局測試
[iscript]
//轉換為tag
f.tag=createAllScript(f.script);
//保存
f.tag.save(sf.path+"scenario/"+f.scenario);
//重寫start.ks
rewriteStart(f.setting.startfrom);
[endscript]
;啟動測試
[eval exp="System.shellExecute(Storages.getLocalName(System.exePath+'project/'+sf.project+'/') + 'krkr.exe')"]
[jump storage="gui_script.ks" target=*window]

;--------------------------------------------------
*重載腳本
[iscript]
//重載並拆分
extractScript();
[endscript]
[jump storage="gui_script.ks"]
;--------------------------------------------------
*關閉腳本
[eval exp="f.window=''"]
;滾動條消除
[freeimage layer=2]
[iscript]
//清除相關內容
f.索引行=void;
f.當前腳本行=void;
f.script=void;
f.腳本顯示=void;
//改回從標題啟動
rewriteStart(f.setting.startfrom);
[endscript]
[jump storage="script_main.ks"]

;--------------------------------------------------
;根據已有的行內容進行編輯
;--------------------------------------------------
*進行編輯
[eval exp="f.window=''"]

[iscript]
//取得行信息
f.參數=%[];
(Dictionary.assign incontextof f.參數)(f.script[f.當前腳本行]);
[endscript]
;--------------------------------------------------
;最後一行
[if exp="f.參數.tagname=='_end'"]
[iscript]
//插入空白行
insertLine();
//重設參數
f.參數=%[];
f.參數.tagname="_blank";
[endscript]
[jump storage="window_tag.ks" target=*window]
;--------------------------------------------------
;一般空白行
[elsif exp="f.參數.tagname=='_blank'"]
[jump storage="window_tag.ks" target=*window]
;--------------------------------------------------
;姓名欄
[elsif exp="findName(f.參數.tagname)"]
[call storage="tag_name.ks"]
;--------------------------------------------------
;非空白行(根據tagname配置表直接call對應的窗口)
[elsif exp="f.target[f.參數.tagname]!=void"]
[call storage="&('tag_'+f.target[f.參數.tagname]+'.ks')"]
[else]
[call storage="tag_direct.ks"]
[endif]
;--------------------------------------------------
[jump storage="gui_script.ks" target=*window]
