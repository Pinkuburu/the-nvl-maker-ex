;------------------------------------------------------------
;養成遊戲專用宏
;背景板顯示在layer 7上
;按鈕顯示在message 1層上
;------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//讀入地圖配置表
//------------------------------------------------------------
//顯示地圖按鈕
function loadmap(name)
{
//創建類並讀入關鍵字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //載入背景
   kag.tagHandlers.image(%["storage" => dic[0]["bgd"],"visible" => true,"left"=>0,"top"=>0,"layer"=>"7","page"=>"back"]);
   
   //循環描繪按鈕
   for (var i=1;i<dic.count;i++)
   {
   //定義按鈕位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   //創建按鈕用字典
   var mapbutton = new Dictionary();
   //取得數據
   mapbutton["normal"]=dic[i]["normal"];
   mapbutton["over"]=dic[i]["over"];
   mapbutton["on"]=dic[i]["on"];
   mapbutton["storage"]=dic[i]["storage"];
   mapbutton["target"]=dic[i]["target"];
   mapbutton["exp"]=dic[i]["exp"];
   
   mapbutton["enterse"]=dic[i]["enterse"];
   mapbutton["clickse"]=dic[i]["clickse"];
   
   //假如有條件，取得條件表達式
   if (dic[i]["cond"]!=void) mapbutton["cond"]=dic[i]["cond"];
   
       //該據點在本地圖上使用到
       if (dic[i]["use"]==1)
      {
           //滿足條件
           if (Scripts.eval(mapbutton["cond"])==true) kag.tagHandlers.button(mapbutton);
           //或者無需條件
           if (mapbutton["cond"]==void) kag.tagHandlers.button(mapbutton);
      }
   }
 }
}
[endscript]
;------------------------------------------------------------
;顯示地圖
;------------------------------------------------------------
[macro name=map]
[rclick enabled="false"]
[backlay]
;隱藏一般對話層
[layopt layer="message0" page="back" visible="false"]
;隱藏系統按鈕層
[layopt layer="message2" page="back" visible="false"]
[position page="back" layer="message1" frame="empty" color="0xFFFFFF" opacity=0 left=0 top=0]
[layopt layer="message1" page="back" visible="true"]
[current layer="message1" page="back"]
[er]
;顯示按鈕
[eval exp=&"'loadmap(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|500]
[wt]
[s]
[endmacro]
;------------------------------------------------------------
;清除地圖
;------------------------------------------------------------
[macro name=clmap]
[backlay]
[freeimage layer=7 page="back"]
[current layer="message1" page="back"]
[er]
[layopt layer="message1" page="back" visible="false"]
;恢復對話框與系統按鈕
[layopt layer="message0" visible="true" page=back]
[layopt layer="message2" visible="true" page="back"]
[trans * method=%method|crossfade time=%time|500]
[wt canskip=%canskip]
;返回對話
[current layer="message0"]
[rclick enabled="true"]
[endmacro]
;------------------------------------------------------------
[return]
