;-------------------------------------------------------------------------------------------
;封裝的宏,對應於指令編輯器
;-------------------------------------------------------------------------------------------
*start

;-------------------------------------------------------------------------------------------
;截圖功能
;-------------------------------------------------------------------------------------------
[iscript]
function savenote(name)
{
	//設定保存路徑
	var fn = System.exePath + "/ScreenShot/" + name;
	//新建一層
	var tmp = new Layer(kag, kag.fore.base);
	tmp.setImageSize(f.setting.width, f.setting.height);
	//用新建層取得當前畫面
	tmp.piledCopy(0, 0, kag.fore.base, 0, 0, f.setting.width, f.setting.height);
	//將當前畫面保存為BMP
	tmp.saveLayerImage(fn + ".bmp", "bmp");
	dm("保存截圖為"+name+".bmp");
}

//獲得日期時間字符串
function getDateString()
{
	var time=new Date();
	
	var str="nvl";
	var year=time.getYear();
	var month=time.getMonth()+1;
	var day=time.getDate();
	
	if (month<10) month="0"+(string)month;
	if (day<10) day="0"+(string)day;
	
	var hour=time.getHours();
	var minute=time.getMinutes();
	var second=time.getSeconds();
	
	if (hour<10) hour="0"+(string)hour;
	if (minute<10) minute="0"+(string)minute;
	if (second<10) second="0"+(string)second;
	
	//最後結果
	str+=(string)year+(string)month+(string)day+"_";
	str+=(string)hour+(string)minute+(string)second;
	return str;
}

function ScreenShot(key, shift)
{	
  dm("按鍵編號"+key);
  
  //106為小鍵盤星號截圖鍵
  if (key != 106)
    return false;

	//保存圖片
	var str=getDateString();
	savenote(str);
}
// 押下時登錄
kag.keyDownHook.add(ScreenShot);
[endscript]
;-------------------------------------------------------------------------------------------
;歷史記錄用的人名顯示效果
;-------------------------------------------------------------------------------------------
[iscript]
//需要修改MyHistoryLayer裡的historyColor
function history_color(text)
{
       if (text!=void && text.charAt(0)=="【")
       {
         var name=text.substring(1,text.length-2);
         var arr=f.config_name;
         
         //為主角
         if (name==f.姓+f.名) return arr[0].color;
         //否則
         //有顏色記錄,使用顏色
           for (var i=2;i<arr.count;i++)
          {
             if (arr[i].name==name) return arr[i].color;
           }
           
         //無顏色記錄,使用路人顏色
         return arr[1].color;
       }
       return kag.fore.messages[0].defaultChColor;
}
[endscript]
;-------------------------------------------------------------------------------------------
;人名顯示基礎
;-------------------------------------------------------------------------------------------
;★npc
[macro name=npc]

[nowait]
[layopt layer="message0" visible="true"]
[current layer="message0"]
[er]

;修改姓名顯示相對位置的地方（去掉下面這行的;，就可以用了，坐標可以為負值）
;[locate x=-50 y=-50]

;使用默認的顏色值
[font color=&"f.config_name[1].color"]
;使用強制設定的值
[font color=%color cond="mp.color!=void"]

;非主角
[if exp="mp.id!='主角'"]
【[emb exp="mp.id"]】
[endif]

;為主角，沒姓名時不顯示
[if exp="mp.id=='主角'"]
[ch text="【" cond="f.姓!=void || f.名!=void"]
[emb exp="f.姓"][emb exp="f.名"]
[ch text="】" cond="f.姓!=void || f.名!=void"]
[endif]
[resetfont]
[r]
[endnowait]

;附加顯示
[backlay]
;頭像
[if exp="mp.face!=void"]
[image layer=8 page="back" storage=%face visible="true"]
;left/top位置自己改吧我不管了，可以用數字，這裡是設成底邊中點自動對齊
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
[endif]
;立繪
[if exp="mp.fg!=void"]
;在原位置顯示圖片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method="crossfade" time=100]
[wt]

[endmacro]
;------------------------------------------------------------------
;準備選項
;------------------------------------------------------------------
[macro name=selstart]
[hr]
[backlay]
;隱藏對話層、消除頭像
[if exp="mp.hidemes"]
[rclick enabled="false"]
[layopt layer="message0" visible="false" page=back]
[freeimage layer="8" page=back]
[endif]
;隱藏按鈕層
[if exp="mp.hidesysbutton"]
[rclick enabled="false"]
[layopt layer="message2" visible="false" page=back]
[endif]
;顯示選項層
[position layer="message1" visible="true" frame="empty" left=0 top=0 marginb=0 marginl=0 marginr=0 margint=0 page=back]
[current layer="message1" page=back]
[nowait]
[endmacro]
;------------------------------------------------------------------
;按鈕選項
;------------------------------------------------------------------
[iscript]
//描繪按鈕文字用函數
function drawSelButton(caption, storage, target)
{
	var button;
	button=kag.current.links[kag.current.links.count-1].object;

	//默認文字樣式設定
	button.font.face = kag.scflags.chDefaultFace;
	button.font.bold = kag.fore.messages[0].defaultBold;
	button.font.height = f.setting.selfont.height;
	
	//sel顏色設定
	var normal=f.setting.selfont.normal;
	var read=f.setting.selfont.read;
	var over=f.setting.selfont.over;
	var on=f.setting.selfont.on;
	
	var edgecolor=kag.fore.messages[0].defaultEdgeColor;
	var shadowcolor=kag.fore.messages[0].defaultShadowColor;

	//將文字對應成預渲染文字
	if ((global.useconfigMappfont) && (f.setting.mapp_sel!=void))
	{
	  button.font.mapPrerenderedFont(f.setting.mapp_sel);
	}

	var w = button.font.getTextWidth(caption); // 取得要描繪文字的寬度
	var x = (button.width - w) \ 2;    // 在按鈕中央顯示文字
	var y = (button.height - button.font.getTextHeight(caption)) \ 2;   //   文字在按鈕上的y位置（左上角起算）

	//取得既讀設定
	var target_name=target.substring(1,target.length-1);
	var checklabel="sf.trail_"+Storages.chopStorageExt(storage)+"_"+target_name;
	var sel_color;

	// 既讀文字顏色設定
	if ((checklabel!)>0 && read!=void) {sel_color=read;}
	else {sel_color=normal;}

	if (kag.fore.messages[0].defaultEdge) //默認設置帶有描邊
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, edgecolor, 1, 0, 0);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, edgecolor, 1, 0, 0);
	}
	else if (kag.fore.messages[0].defaultShadow)//默認設置帶有陰影
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true, 255, shadowcolor, 0, 2, 2);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true, 255, shadowcolor, 0, 2, 2);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true, 255, shadowcolor, 0, 2, 2);
	}
	else //無任何效果
	{
		// 按鈕「通常狀態」部分文字顯示
		button.drawText(x,y, caption, sel_color, 255, true);
		// 按鈕「按下狀態」部分文字顯示
		button.drawText(x+button.width, y, caption, on ,255, true);
		// 按鈕「選中狀態」部分文字顯示
		button.drawText(x+button.width+button.width, y, caption, over ,255, true);
	}

}
[endscript]

[macro name=selbutton]
;假如沒有填寫選擇條,使用默認選擇條
[eval exp="mp.normal=f.setting.selbutton.normal" cond="mp.normal==void"]
[eval exp="mp.over=f.setting.selbutton.over" cond="mp.over==void"]
[eval exp="mp.on=f.setting.selbutton.on" cond="mp.on==void"]
[eval exp="mp.enterse=f.setting.selbutton.enterse" cond="mp.enterse==void"]
[eval exp="mp.clickse=f.setting.selbutton.clickse" cond="mp.clickse==void"]

;假如沒有填寫劇本，則讀取當前執行中的劇本名
[if exp="mp.storage==void"]
[eval exp="mp.storage=Storages.extractStorageName(kag.conductor.curStorage)"]
[endif]

;顯示按鈕（根據有無音效切換）
[if exp="mp.enterse!=void && mp.clickse!=void"]
[button enterse=%enterse clickse=%clickse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[elsif exp="mp.enterse!=void"]
[button enterse=%enterse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[elsif exp="mp.clickse!=void"]
[button clickse=%clickse storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[else]
[button storage=%storage normal=%normal over=%over on=%on target=%target exp=%exp]
[endif]

;描繪選項文字
[eval exp="drawSelButton(mp.text,mp.storage,mp.target)"]

[endmacro]
;------------------------------------------------------------------
;等待選擇-選項
;------------------------------------------------------------------
[iscript]
//讓所有按鈕自動居中對齊的效果
function Arrange_SelButton(num)
{
	var x=f.setting.selbutton.left;
	var y=f.setting.selbutton.top;
	var width=f.setting.selbutton.width;
	var height=f.setting.selbutton.height;
	
	var per_height=f.setting.selbutton.height/(num+1);

	for (var i=0;i<num;i++)
	{
		kag.current.links[i].object.left=x+(width-kag.current.links[i].object.width)/2;
		kag.current.links[i].object.top=(int)y+(int)per_height*(i+1);
		
		dm("選項按鈕"+(i+1));
		dm("x="+kag.current.links[i].object.left);
		dm("y="+kag.current.links[i].object.top);
	}

}
[endscript]
[macro name=selend]
[endnowait]
;假如是限時選項，強制將系統菜單無效化
[if exp="mp.timeout"]
[history enabled="false"]
[rclick enabled="false"]
[layopt layer="message2" visible="false" page=back]
[endif]
;按鈕排列處理
[eval exp="Arrange_SelButton(kag.current.links.count)"]
[trans method=%method|crossfade time=%time|300 rule=%rule|1 from=%from stay=%stay]
[wt canskip=%canskip]
;限時選項處理
[if exp="mp.timeout"]
[timeout time=%outtime storage=%storage target=%target]
[endif]
[if exp="mp.timebar"]
[timebar bar=%bar x=%x y=%y time=%outtime width=%width bgimage=%bgimage bgx=%bgx bgy=%bgy]
[endif]
[s]
[endmacro]
;------------------------------------------------------------------
;★清理選項
;------------------------------------------------------------------
[macro name=clsel]
[deltimebar]
[rclick enabled="true" call="true" jump="false" storage="rclick.ks" target="*隱藏對話框"]
[history enabled="true"]
[backlay]
[layopt layer="message1" visible="false" page="back"]

;恢復對話框與系統按鈕
[layopt layer="message0" visible="true" page=back]
[layopt layer="message2" visible="true" page="back"]
[trans method=%method|crossfade time=%time|100 rule=%rule|1 from=%from stay=%stay]
[wt canskip=%canskip]
;返回對話
[current layer="message0"]
[endmacro]
;------------------------------------------------------------------
;文字連接
;------------------------------------------------------------------
[macro name=links]
[link *][ch text=%text][endlink]
[endmacro]
;-------------------------------------------------------------------------------------------
;播放視頻
;-------------------------------------------------------------------------------------------
[macro name=playmv]
[video width="1024" left="0" visible="true" height="768" top="0"]
[playvideo storage=%storage]
[wv canskip=%canskip|true]
[endmacro]
;-------------------------------------------------------------------------------------------
;播放語音
;-------------------------------------------------------------------------------------------
[iscript]
//簡單的播放語音函數
function playse(file,buf=1,isloop=false)
{
	kag.tagHandlers.playse(%[
	"storage"=>file,
	"buff"=>buf,
	"loop"=>isloop
	]);
}
[endscript]

[macro name=vo]
[eval exp="f.voing=true"]
[playse storage=%storage buf="1" loop="false"]
[hact exp=&("playse("+"\""+mp.storage+"\""+")")]
[endmacro]

[macro name=endvo]
[if exp="f.voing==true"]
[eval exp="f.voing=false"]
[endhact]
[ws buf="1"]
[endif]
[endmacro]
;------------------------------------------------------------------
;★等待
;------------------------------------------------------------------
[macro name=lr]
[endvo]
[l][r]
[endmacro]

[macro name=w]
[endvo]
[p]
[freeimage layer=8 page=fore]
[cm]
[endmacro]
;------------------------------------------------------------------
;★普通對話框(含頭像)
;------------------------------------------------------------------
[macro name=dia]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.dia.frame" left=&"f.config_dia.dia.left" top=&"f.config_dia.dia.top" marginl=&"f.config_dia.dia.marginl" marginr=&"f.config_dia.dia.marginr" margint=&"f.config_dia.dia.margint" marginb=&"f.config_dia.dia.marginb"]
[layopt layer="message2" visible="true" page="back"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------------
;★全屏對話框(不含頭像)
;------------------------------------------------------------------
[macro name=scr]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame=&"f.config_dia.scr.frame" left=&"f.config_dia.scr.left" top=&"f.config_dia.scr.top" marginl=&"f.config_dia.scr.marginl" marginr=&"f.config_dia.scr.marginr" margint=&"f.config_dia.scr.margint" marginb=&"f.config_dia.scr.marginb"]
[layopt layer="message2" visible="true" page="back"]
;有效化系統按鈕層
[eval exp="kag.back.messages[2].enabled=true"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------------
;★透明全屏對話框
;------------------------------------------------------------------
[macro name=menu]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
[freeimage layer=8 page="back"]
[current layer="message0" page="back"]
[position page="back" layer="message0" visible="true" frame="empty" left=0 top=0 marginl=&"f.config_dia.blank.marginl" marginr=&"f.config_dia.blank.marginr" margint=&"f.config_dia.blank.margint" marginb=&"f.config_dia.blank.marginb"]
[layopt layer="message2" visible="false" page="back"]
[trans method="crossfade" time=200]
[wt]
[current layer="message0" page="fore"]
[cm]
[endmacro]
;------------------------------------------------------------
;★隱藏對話框
;------------------------------------------------------------
[macro name=hidemes]
[backlay]
;隱藏對話框
[layopt layer="message0" page="back" visible="false"]
;隱藏系統按鈕
[layopt layer="message2" page="back" visible="false"]
;隱藏頭像
[layopt layer=8 page="back" visible="false"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;------------------------------------------------------------
;★顯示對話框
;------------------------------------------------------------
[macro name=showmes]
[backlay]
;隱藏對話框
[layopt layer="message0" page="back" visible="true"]
;隱藏系統按鈕
[layopt layer="message2" page="back" visible="true"]
;隱藏頭像
[layopt layer=8 page="back" visible="true" cond="kag.back.layers[8].width>32"]
[trans method="crossfade" time=100]
[wt]
[current layer=message0 page=back]
[er]
[current layer=message0 page=fore]
[endmacro]
;------------------------------------------------------------------
;★顯示背景
;------------------------------------------------------------------
[macro name=bg]
[backlay]
;一般效果
[image layer=base storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity]
;反色效果
[if exp="mp.convert==true"]
[image layer=base storage=%storage|black page=back visible="true" left=0 top=0 grayscale=%grayscale|false mcolor=%mcolor mopacity=%mopacity rceil=0 gceil=0 bceil=0 rfloor=255 bfloor=255 gfloor=255]
[endif]

;消除立繪
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]

;消除對話框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除背景
;------------------------------------------------------------------
[macro name=clbg]
[backlay]
[freeimage layer=base page="back"]
;連同全部前景
[if exp="mp.clfg==true"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]

;連同對話框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]

[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★顯示人物
;------------------------------------------------------------------
[macro name=fg]
[backlay]
;第一次顯示,指定角色位置
[if exp="mp.pos!=''"]
[image * storage=%storage|empty layer=%layer|0 page="back" pos=%pos visible="true"]
[else]
;不指定時,自動調整,使立繪顯示在原位置/指定位置
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left" cond="mp.left==void"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top" cond="mp.top==void"]
[image * storage=%storage layer=%layer page="back" left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|500 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★消除人物
;------------------------------------------------------------------
[macro name=clfg]
[backlay]
;消除全部
[if exp="mp.layer=='all'"]
[freeimage layer=0 page="back"]
[freeimage layer=1 page="back"]
[freeimage layer=2 page="back"]
[freeimage layer=3 page="back"]
[freeimage layer=4 page="back"]
[freeimage layer=5 page="back"]
[freeimage layer=6 page="back"]
[freeimage layer=7 page="back"]

[freeimage layer=8 page="back"]
[endif]
;消除單層
[if exp="mp.layer!='all'"]
[freeimage layer=%layer page="back"]
[endif]
;消除頭像
[if exp="mp.clface==true"]
[freeimage layer=8 page="back"]
[endif]
;連同對話框
[if exp="mp.hidemes==true"]
[current layer="message0" page="back"]
[er]
[current layer="message1" page="back"]
[er]
[current layer="message2" page="back"]
[er]
[layopt layer="message0" visible="false" page="back"]
[layopt layer="message1" visible="false" page="back"]
[layopt layer="message2" visible="false" page="back"]
[endif]
[trans method=%method|crossfade time=%time|700 rule=%rule stay=%stay from=%from]
[wt canskip=%canskip|true]
[endmacro]
;------------------------------------------------------------------
;★顯示頭像
;------------------------------------------------------------------
[macro name=face]
[backlay]
[image * layer=8 visible="true" page="back" storage=%storage|empty]
[layopt layer=8 page="back" left=&"(int)f.config_dia.face.left-kag.back.layers[8].width\2" top=&"(int)f.config_dia.face.top-kag.back.layers[8].height"]
;附加顯示立繪
[if exp="mp.fg!=void"]
;在原位置顯示圖片
[eval exp="mp.layer='0'" cond="mp.layer==''"]
[eval exp="mp.left=kag.fore.layers[mp.layer].left"]
[eval exp="mp.top=kag.fore.layers[mp.layer].top"]
[image layer=%layer page="back" storage=%fg left=%left top=%top visible="true"]
[endif]
[trans method=%method|crossfade time=%time|100 rule=%rule|1]
[wt]
[endmacro]
;------------------------------------------------------------------
;★消除頭像
;------------------------------------------------------------------
[macro name=clface]
[backlay]
[freeimage layer=8 page="back"]
[trans method="crossfade" time=100]
[wt]
[endmacro]
;------------------------------------------------------------
;★播放音樂
;------------------------------------------------------------
[macro name=bgm]
[xchgbgm * storage=%storage overlap=%overlap|500 time=%time|1000]
[endmacro]
;------------------------------------------------------------
;★播放音效
;------------------------------------------------------------
[macro name=se]
[if exp="mp.time==void"]
[playse storage=%storage loop=%loop|false buf=%buf|0]
[else]
[fadeinse storage=%storage loop=%loop|false buf=%buf|0 time=%time|0]
[endif]
[endmacro]
;-------------------------------------------------------------------------------------------
;★移動基礎
;-------------------------------------------------------------------------------------------
[macro name=movepos]
[eval exp="tf.layer=0"]
[eval exp="tf.layer=mp.layer" cond="mp.layer!=''"]
[eval exp="tf.left=kag.fore.layers[tf.layer].left"]
[eval exp="tf.top=kag.fore.layers[tf.layer].top"]
[eval exp="tf.oop=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=0"]
[eval exp="tf.y=0"]
[eval exp="tf.opacity=kag.fore.layers[tf.layer].opacity"]
[eval exp="tf.x=mp.x" cond="mp.x!=''"]
[eval exp="tf.y=mp.y" cond="mp.y!=''"]
[eval exp="tf.opacity=mp.opacity" cond="mp.opacity!=''"]
[eval exp="tf.x2=tf.left*1+mp.x*1"]
[eval exp="tf.y2=tf.top*1+mp.y*1"]
[eval exp="tf.path='('+&tf.x2+','+&tf.y2+','+&tf.opacity+')'"]
[move layer=%layer|0 path="&tf.path" time=%time|100 accel=%accel]
[wm canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
;★背景搖晃
;-------------------------------------------------------------------------------------------
[macro name=shake]
[action layer=base module=LayerWaveActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='wave'"]
[action layer=base module=LayerJumpActionModule vibration=10 cycle=100 time=400 cond="mp.dir=='jump'"]
[wact canskip=%canskip]
[endmacro]
;-------------------------------------------------------------------------------------------
[return]
