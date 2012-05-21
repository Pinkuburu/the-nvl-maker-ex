;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;界面的描繪
;------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------
;通用的翻頁刷新操作
;-----------------------------------------------------------------------------------------------
[iscript]
//通用翻頁上
function page_up(scale)
{
    if (f.window!='' && f.window!='script')
    {
      if (f.curpage>1) f.curpage--;
      update();
    }
    else if (f.window=='script')
    {
      while (scale>0) {line_up();scale--;}
      updateScript();
    }
}
//-----------------------------------------------------------------------------------------------
//通用翻頁下
function page_down(scale)
{
    if (f.window!='' && f.window!='script')
    {
      if (f.curpage<f.page) f.curpage++;
      update();
    }
        else if (f.window=='script')
    {
      while (scale<0) {line_down();scale++;}
      updateScript();
    }
}
//-----------------------------------------------------------------------------------------------
//一般計算頁數
function countPage(count,line)
{
   //計算頁數
   f.page=count\line;
   if (count%line>0) f.page++;
   //默認翻到最後一頁
   f.curpage=f.page;   
   //默認不選中
   f.select=count;
}
//-----------------------------------------------------------------------------------------------
//一般選擇一行
function setselect(num,line)
{
   //未選擇
   if (f.select!=num+line*(f.curpage-1))
   {
     f.select=num+line*(f.curpage-1);
     update();
   }
   
   //已選擇,顯示圖片預覽窗口
   if (f.window=="picture" && f.list[f.select]!=void) tf.preview.getPicture(f.list[f.select].name);
   
}

//-----------------------------------------------------------------------------------------------
//一般拖動
function page_scroll()
{
     if (kag.fore.base.cursorY<kag.fore.layers[9].top) page_up();
     if (kag.fore.base.cursorY>(int)kag.fore.layers[9].top+(int)kag.fore.layers[9].height) page_down();
}
//-----------------------------------------------------------------------------------------------
//一般描繪
function update()
{
    switch(f.window)
    {
       //為選擇工程窗口的情況
        case "project":
                drawBox("文件夾",kag.fore.layers[7],20,50,150,10,f.project,f.curpage-1);
                drawBox("名稱",kag.fore.layers[7],169,50,170,10,f.title,f.curpage-1);
                kag.fore.layers[9].top=kag.fore.layers[7].top+66;
                if (f.page>1) kag.fore.layers[9].top+=(int)(f.curpage-1)*173/(f.page-1);
                break;
       //為選擇字體窗口的情況
        case "font":
                updateFont();
                break;
       //為一般文件選擇
        case "file":
                updateFile();
                break;
        //為圖片
        case "picture":
                updatePicture();
                break;
    }
}
[endscript]
;------------------------------------------------------------------------------------------------
;很少用的描繪組
;------------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;描繪按鈕
;---------------------------------------------------------------
[iscript]
function drawButtonCaption(caption,size=18)
{
var button=kag.current.links[kag.current.links.count-1].object;
button.font.face = "幼圓"; //改字體的地方...
button.font.height = size;     //文字大小設定

var w = button.font.getTextWidth(caption); // 取得要描繪文字的寬度
var x = (button.width - w) \ 2;    // 在按鈕中央顯示文字
var y = (button.height - size) \ 2-1;   //   文字在按鈕上的y位置（左上角起算）
var color=0x000000;
var edge=0xFFFFFF;
// 按鈕「通常狀態」部分文字顯示
button.drawText(x,                           y, caption, color,255,true,255,edge,1,0,0);
// 按鈕「按下狀態」部分文字顯示
button.drawText(x+button.width,              y, caption, color,255,true,255,edge,1,0,0);
// 按鈕「選中狀態」部分文字顯示
button.drawText(x+button.width+button.width, y, caption, color,255,true,255,edge,1,0,0);
}
[endscript]

;--------------------------------------------------------------
;主界面頁背景
;--------------------------------------------------------------
[iscript]
function drawPageBoard(x=1)
{
 //底板
  with(kag.fore.layers[0])
  {
     .visible=true;
     .left=10;
     .top=81;
     .width=1370;
     .height=850;
     //底板
     .fillRect(0,0,1370,850,0xFFD4D0C8);
     //.fillRect(0,0,1400,610,0xFFD4D0C8);
     //描邊
     .fillRect(0,0,1370,1,0xFFFFFFFF);
     .fillRect(0,0,1,850,0xFFaca899);
     .fillRect(1,0,1,850,0xFFFFFFFF);
     .fillRect(0,849,1370,1,0xFFaca899);
     .fillRect(1369,0,1,850,0xFFaca899);
     //當前顯示第幾頁，補描繪按鈕下空白
     .fillRect(x,0,68,1,0xFFD4D0C8);
  }
  //編輯器界面
  with(kag.fore.messages[1])
  {
     .visible=true;
     .left=10;
     .top=81;
     .width=1370;
     .height=850;
  }
}
[endscript]

;--------------------------------------------------------------
;TAG頁背景
;--------------------------------------------------------------
[iscript]
function drawTagBoard(x=2,a=15,b=251,w=610,h=210)
{
 //底板
  with(kag.fore.layers[3])
  {
     //底板
     .fillRect(a,b,w,h,0xFFD4D0C8);
     //描邊
     .fillRect(a,b,w,1,0xFFFFFFFF);//橫1
     .fillRect(a,b,1,h,0xFFaca899);//縱1
     .fillRect(a+1,b,1,h,0xFFFFFFFF);//縱2
     .fillRect(a,b+h-1,w,1,0xFFaca899);//橫陰影
     .fillRect(a+w-1,b,1,h,0xFFaca899);//縱陰影
    //當前顯示第幾頁，補描繪按鈕下空白
     .fillRect(a+x,b,68,1,0xFFD4D0C8);
  }
}
[endscript]
;--------------------------------------------------------------
;功能分隔欄
;--------------------------------------------------------------
[iscript]
function drawFrame(title,line=7,x=15,y=15,layer=kag.fore.layers[0],width=314)
{
var height=(line+1)*30;

  with(layer)
  {
     .font.height=16;
     .font.mapPrerenderedFont("font_16.tft");
  //上
      .fillRect(x,y,width,1,0xFFaca899);
      .fillRect(x,y+1,width,1,0xFFFFFFFF);
  //下
      .fillRect(x,y+height,width+1,1,0xFFaca899);
      .fillRect(x,y+height+1,width+2,1,0xFFFFFFFF);
  //左
      .fillRect(x,y,1,height,0xFFaca899);
      .fillRect(x+1,y+1,1,height-1,0xFFFFFFFF);
  //右
      .fillRect(x+width,y,1,height+1,0xFFaca899);
      .fillRect(x+width+1,y,1,height+1,0xFFFFFFFF);
  //標題描繪區域
      .fillRect(x+10,y,layer.font.getTextWidth(title)+10,1,0xFFD4D0C8);
      .fillRect(x+10,y+1,layer.font.getTextWidth(title)+10,1,0xFFD4D0C8);
  //文字
      .drawText(x+15,y-6, title, 0x000000);
  }
}
[endscript]
;------------------------------------------------------------------------------------------------
;常用控件組
;------------------------------------------------------------------------------------------------
[iscript]
//--------------------------------------------------------------
//參數複製函數
//--------------------------------------------------------------
function copy(value)
{
kag.current.commit();
return value!;
}
//--------------------------------------------------------------
//基本edit框描繪[標題,處理值,位置,條件]
//--------------------------------------------------------------
function drawEdit(title,value,posX,posY,length=224,cond='')
{
  //描繪提示文字

  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  
  var width=kag.current.font.getTextWidth(title);
  kag.tagHandlers.locate(%["x"=>posX+width+20,"y"=>posY]);
  
  if (value!=void)
  {
      //描繪編輯框
      var result=cond!;
      var setting=new Dictionary();
      setting.name=value;
      setting.length=length-width;
       //值為偽時，設定特殊顏色
       if (result==false && cond!=void)
       {
            setting.bgcolor=0xD4D0C8;
            setting.color=0xD4D0C8;
        }
       kag.tagHandlers.edit(setting);
  }
}
//--------------------------------------------------------------
//附加連接框□的描繪、圖片選擇窗口[處理值，路徑，聯動寬高]
//--------------------------------------------------------------
function drawLink_Picwin(value,path,withwidth='',withheight='')
{
   //空格
   kag.tagHandlers.ch(%["text"=>" "]);
   //連接
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.當前編輯值=\'"+value+"\'";
   setting.hint="點此打開圖片選擇窗口";
   setting.target="*選擇圖片";
   //根據路徑,傳入必須參數
   if (Scripts.eval("f."+path)==void) Scripts.eval("f."+path+"=loadpic("+"'"+path+"')");
   setting.exp+=",f.list=f."+path;
   kag.tagHandlers.link(setting);
   //方塊
   kag.tagHandlers.ch(%["text"=>"□"]);
   kag.tagHandlers.endlink(%[]);
}
//      //選擇圖片文件（縮略圖）
//      case "pic":
//           setting.exp+=",f.list=f."+path;
//           setting.hint="點此打開圖片選擇窗口";
//           setting.target="*選擇圖片";
//           break;
           
//--------------------------------------------------------------
//附加連接框□的描繪、圖片以外[處理值，打開的窗口類型(擴展名,路徑無法更改)]
//--------------------------------------------------------------
function drawLink_Win(value,type)
{
   //空格
   kag.tagHandlers.ch(%["text"=>" "]);
   //連接
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.當前編輯值=\'"+value+"\'";
   //根據文件類型進行設定
   switch (type)
   {
      //選擇顏色
      case "color":
           setting.hint="點此打開顏色選擇窗口";
           setting.target="*選擇顏色";
           break;
      //選擇字體文件（範例文字）
      case "font":
           setting.exp+=",f.list=kag.fore.base.font.getList(fsfNoVertical)";
           setting.hint="點此打開字體選擇窗口";
           setting.target="*選擇字體";
           break;
     //音樂音效
      case "music":
           setting.exp+=",f.list=getsozai('bgm','bgm')";
           setting.hint="點此打開音樂選擇窗口";
           setting.target="*選擇音聲";
           break;
      case "sound":
           setting.exp+=",f.list=getsozai('se','sound')";
           setting.hint="點此打開音效選擇窗口";
           setting.target="*選擇音聲";
           break;
      //語音
      case "voice":
           setting.exp+=",f.list=getsozai('se','voice')";
           setting.hint="點此打開語音選擇窗口";
           setting.target="*選擇音聲";
           break;
      //選擇劇本類文件
      case "script":
           setting.exp+=",f.list=getsozai('ks','scenario')";
           setting.hint="點此打開劇本選擇窗口";
           setting.target="*選擇文件";
           break;
       //選擇鼠標類文件
       case "cursor":
           setting.exp+=",f.list=getsozai('cur','others')";
           setting.hint="點此打開鼠標文件選擇窗口";
           setting.target="*選擇文件";
           break;
      //姓名編輯器
       case "name":
           setting.hint="點此打開姓名詳細編輯窗口";
           setting.target="*編輯姓名";
           break;
      //選擇地圖
       case "map":
           setting.exp+=",f.list=getsozai('map','map')";
           setting.hint="點此打開地圖文件選擇窗口";
           setting.target="*選擇文件";
           break;
       //選擇養成面板
       case "edu":
           setting.exp+=",f.list=getsozai('edu','map')";
           setting.hint="點此打開養成面板文件選擇窗口";
           setting.target="*選擇文件";
           break;
       //生成tjs式
       case "cond":
           setting.hint="點此打開TJS條件生成器";
           setting.target="*生成條件";
           break;
   }
   kag.tagHandlers.link(setting);
   //方塊
   kag.tagHandlers.ch(%["text"=>"□"]);
   kag.tagHandlers.endlink(%[]);
}
//--------------------------------------------------------------
//附加連接框▽的描繪[轉到的菜單target]
//--------------------------------------------------------------
function drawLink_List(target)
{
       //描繪下拉菜單
       kag.tagHandlers.ch(%["text"=>" "]);
       kag.tagHandlers.link(%[
       "hint"=>"點此打開下拉菜單",
       "target"=>target
       ]);
       kag.tagHandlers.ch(%["text"=>"▽"]);
       kag.tagHandlers.endlink(%[]);
}
[endscript]
;--------------------------------------------------------------
;特殊描繪-位置行
;--------------------------------------------------------------
[iscript]
function drawPos(valueX,valueY,posX,posY,cond='',sample='')
{
    //描繪提示文字
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>"x"]);
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+30]);
  kag.tagHandlers.ch(%["text"=>"y"]);
  var result=cond!;
  if (cond==void || result==true)
  {
  //x
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY]);
       kag.tagHandlers.edit(%["name"=>valueX]);
  //y
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY+30]);
       kag.tagHandlers.edit(%["name"=>valueY]);
  //link
//       kag.tagHandlers.ch(%["text"=>" "]);
//       kag.tagHandlers.link(%[
//       "hint"=>"點此打開位置設定窗口"
//       ]);
//       kag.tagHandlers.ch(%["text"=>"□"]);
//       kag.tagHandlers.endlink(%[]);
    }
    else if (result==false)
    {
  //x
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY]);
       kag.tagHandlers.edit(%["name"=>valueX,"bgcolor"=>0xD4D0C8,"color"=>0xD4D0C8]);
  //y
       kag.tagHandlers.locate(%["x"=>posX+30,"y"=>posY+30]);
       kag.tagHandlers.edit(%["name"=>valueY,"bgcolor"=>0xD4D0C8,"color"=>0xD4D0C8]);
  //link
//       kag.tagHandlers.ch(%["text"=>" "]);
//       kag.tagHandlers.link(%[
//       "hint"=>"點此打開位置設定窗口"
//       ]);
//       kag.tagHandlers.ch(%["text"=>"□"]);
//       kag.tagHandlers.endlink(%[]);
    }
}
[endscript]
;--------------------------------------------------------------
;特殊描繪-獨立選框
;--------------------------------------------------------------
[iscript]
function drawCheck(title,value,posX,posY)
{
  //描繪勾選框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+6]);
  //取得值
  var result=value!;
  //值為空(默認)
    if (result===void)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_void",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值為真
  else if (result==true || result=="true")
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_over",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值為假
  else if (result==false || result=="false")
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_check_normal",
    "exp"=>"kag.current.commit(),"+value+"=true",
    "target"=>"*window"
    ]);
  }
  //描繪提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
}
[endscript]
;--------------------------------------------------------------
;特殊描繪-互斥選框(A值為T,則B值強制為F)
;--------------------------------------------------------------
[iscript]
function drawOption(title,value,posX,posY,negvalue)
{
  //描繪提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  //描繪勾選框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+5]);
  //取得值
  var result=value!;
  //值為真
  if (result==true)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_over",
    "exp"=>"kag.current.commit(),"+value+"=false",
    "target"=>"*window"
    ]);
  }
  //值為假
  else if (result==false)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_normal",
    "exp"=>"kag.current.commit(),"+value+"=true,"+negvalue+"=false",
    "target"=>"*window"
    ]);
  }

}
[endscript]
;--------------------------------------------------------------
;特殊描繪-互斥選框2(比較值A和B)
;--------------------------------------------------------------
[iscript]
function drawGroup(title,value,posX,posY,comp)
{
//value=變數名
//comp=默認值
//當兩值相等時為真
  //描繪提示文字
  kag.tagHandlers.locate(%["x"=>posX+25,"y"=>posY]);
  kag.tagHandlers.ch(%["text"=>title]);
  //描繪勾選框
  kag.tagHandlers.locate(%["x"=>posX,"y"=>posY+5]);
  //取得值
  var result=value!;
  
  if (result==comp)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_over",
    "exp"=>"kag.current.commit(),"+value+"='"+comp+"'",
    "target"=>"*window"
    ]);
  }
  else if (result!=comp)
  {
    kag.tagHandlers.button(%[
    "normal"=>"edit_option_normal",
    "exp"=>"kag.current.commit(),"+value+"='"+comp+"'",
    "target"=>"*window"
    ]);
  }
  
}
[endscript]
;---------------------------------------------------------------
;描繪基本窗口
;---------------------------------------------------------------
[iscript]
function drawWin(layer,message,title,width,height)
{
    with(layer)
  {
     .visible=true;
     .left=(kag.scWidth-width)/2;
     .top=(kag.scHeight-height)/2;
     if (.top>=10) .top=10;
     .width=width;
     .height=height;
     //底板
     .fillRect(0,0,width,height,0xFFD4D0C8);
     .fillRect(0,0,width,1,0xFFFFFFFF);
     .fillRect(0,0,1,height,0xFFFFFFFF);
     .fillRect(0,height-1,width,1,0xFFaca899);
     .fillRect(width-1,0,1,height,0xFFaca899);
     //標題欄
     .fillRect(2,2,width-4,25,0xFF408080);
     //文字
     .font.height=18;
     .font.mapPrerenderedFont("font_18.tft");
     .drawText(4,5, title, 0xFFFFFF);
     .font.height=16;
  }
  //菜單
  with(message)
  {
     .visible=true;
     .left=(kag.scWidth-width)/2;
     .top=(kag.scHeight-height)/2;
     if (.top>=10) .top=10;
     .width=width;
     .height=height;
  }  
}
[endscript]
;---------------------------------------------------------------
;描繪文件listbox/描繪listbutton
;---------------------------------------------------------------
[iscript]
function drawBox(title,layer,left,top,width,line,array,page=0)
{
//設定長度
var height=(line+1)*20+5;
     with(layer)
  {
      .font.height=16;
      .font.mapPrerenderedFont("font_16.tft");
     //底板
     .fillRect(left,top,width,height,0xFFFFFFFF);
     //標題
     .fillRect(left+1,top+1,width-2,20,0xFFD8D8D8);

     .drawText(left+5,top+4,title,0x000000);
     .fillRect(left+1,top+21,width-2,1,0xFFaca899);
     //邊框
     .fillRect(left,top,width,1,0xFFaca899);
     .fillRect(left,top,1,height,0xFFaca899);  
     .fillRect(left,top+height-1,width,1,0xFFaca899);
     .fillRect(left+width-1,top,1,height,0xFFaca899);
     //列表
     for (var i=line*page;i<line*page+line;i++)
     {
       if (i>=array.count) break;
       //選中
       if (f.select==i) .fillRect(left+1,top+23+(i-line*page)*20,width-2,20,0xFFCAFFFF);
       //文字
       var color=0x000000;
       //飄紅prelogue.ks，使第一次使用者知道打開哪個文件
       if (array[i]=="prelogue.ks") color=0xFF0000;
       .drawText(left+5,top+1+24+(i-line*page)*20, array[i],color);
     }
  }
}

function drawButtonLine(posX,posY,normal,line,height)
{
  for (var i=0;i<line;i++)
  {
     kag.tagHandlers.locate(
     %[
         "x"=>posX,
         "y"=>posY+height*i
      ]
      );
      var setting=new Dictionary();
      setting.normal=normal;
      setting.exp="setselect("+i+","+line+")";
      kag.tagHandlers.button(setting);
  }
}
[endscript]

;-----------------------------------------------------------------------------------
[return]
