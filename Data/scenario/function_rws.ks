;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
[iscript]

//將tjs變數文件轉為xml文件
function tjs_to_xml(filename)
{
	//保存XML
	var a = Scripts.evalStorage(sf.path+"macro/"+filename+".tjs");
	//添加unicode標記
	var b = "<?xml version=\"1.0\" encoding=\"Unicode\"?>";
	//轉換
	b+=tjsvartoxml(a);
	//調整格式
	var c = new RegExp("><","g");
	var d = b.replace(c,">\n<");
	var e = d.split('\r\n',,true);
	e.save(sf.path+"macro/"+filename+".xml");
}

//將xml文件轉為tjs變數文件
function xml_to_tjs(filename)
{
	var a = [];
	a.load(sf.path+"macro/"+filename+".xml");
	var b = a.join("\n",false,true);
	var c = xmltotjsvar(b);
	c.saveStruct(sf.path+"macro/"+filename+".tjs");
}

[endscript]
;------------------------------------------------------------------------------------------------
;通用的文本文件的選擇,載入,保存,重寫
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------
;重寫啟動腳本
;------------------------------------------------------------------
[iscript]
function rewriteStart(storage)
{
//自動生成宏
var arr=[];
arr[0]=";--------------------------------------------";
arr[1]=";由編輯器自動改寫以方便測試的跳轉腳本";
arr[2]=";--------------------------------------------";
arr[3]="[jump storage=\""+storage+"\"]";

//進行保存
arr.save(sf.path+"macro/start.ks");
}
[endscript]

;------------------------------------------------------------------
;讀入文本文件
;------------------------------------------------------------------
[iscript]
function loadScript(file)
{
var script=[];
script.load(file);
return script;
}
[endscript]
;------------------------------------------------------------------
;保存文本文件
;------------------------------------------------------------------
[iscript]
function saveScript(filename,script)
{
  Plugins.link("win32ole.dll");
  var objFileSystem = new WIN32OLE("Scripting.FileSystemObject");
  var objTextFile = objFileSystem.OpenTextFile(filename , 2 ,true ,-1);
  //參數:文件名,(只讀1/只寫2/續寫8),不存在是否新建(true/false),(默認-2/UNICODE-1/ASCII0)
  for (var i=0;i<script.count;i++)
   {
       objTextFile.WriteLine(script[i]);
    }
objTextFile.Close();
}
[endscript]
;------------------------------------------------------------------
;保存設定文件
;------------------------------------------------------------------
[iscript]
function saveConfig()
{
//讀入模板設定
var cont;
cont=loadScript(sf.path+"Config.tjs");

//按行改寫部分內容
for (var i=0;i<cont.count;i++)
{
	if (cont[i].indexOf(";System.title")!=-1) cont[i]=";System.title =\""+f.setting.title+"\";";
	if (cont[i].indexOf(";scWidth")!=-1) cont[i]=";scWidth ="+f.setting.width+";";
	if (cont[i].indexOf(";scHeight")!=-1) cont[i]=";scHeight ="+f.setting.height+";";
	
	if (cont[i].indexOf(";scPositionX.left_center")!=-1) {cont[i]=";scPositionX.left_center = "+(f.setting.width*3/8)+";";}
	else if (cont[i].indexOf(";scPositionX.left")!=-1) {cont[i]=";scPositionX.left = "+f.setting.width/4+";";}
	
	if (cont[i].indexOf(";scPositionX.center")!=-1) cont[i]=";scPositionX.center = "+f.setting.width/2+";";
	
	if (cont[i].indexOf(";scPositionX.right_center")!=-1) {cont[i]=";scPositionX.right_center = "+(f.setting.width*5/8)+";";}
	else if (cont[i].indexOf(";scPositionX.right")!=-1) {cont[i]=";scPositionX.right =  "+(f.setting.width*3/4)+";";}
	
	if (cont[i].indexOf(";mw")!=-1) cont[i]=";mw = "+f.setting.width+";";
	if (cont[i].indexOf(";mh")!=-1) cont[i]=";mh ="+f.setting.height+";";
}

//----------------------------------------------------------
//保存設定文件
//----------------------------------------------------------
saveScript(Storages.getLocalName(sf.path+"Config.tjs"),cont);
}
[endscript]
;------------------------------------------------------------------
[return]
