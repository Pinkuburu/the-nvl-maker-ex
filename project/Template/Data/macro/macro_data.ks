;-------------------------------------------------------------------------------------------
;載入xml文件並返回變數
;-------------------------------------------------------------------------------------------
[iscript]
//添加數據庫文件夾
Storages.addAutoPath("xml/");

//將tjs變數文件轉為xml文件（測試用）
function tjs_to_xml(filename)
{
        //保存XML
        var a = Scripts.evalStorage(filename+".tjs");
        var b = tjsvartoxml(a);
        var c = new RegExp("><","g");
        var d = b.replace(c,">\n<");
        var e = d.split('\r\n',,true);
        e.save("xml/"+filename+".xml");
}

//讀入XML文件並返回對應的tjs變數
function load_xml(filename)
{
	var a = [];
	a.load(filename+".xml");
	var b = a.join("\n",false,true);
	var c = xmltotjsvar(b);
	return c;
}
[endscript]
;-------------------------------------------------------------------------------------------
;對變數的處理
;-------------------------------------------------------------------------------------------
[iscript]
function load_dic()
{
	var a=%[];
	a=load_xml("dictionary");
	return a;
}
function load_arr()
{
	var a=[];
	a=load_xml("item");
	return a;
}

[endscript]
;-------------------------------------------------------------------------------------------
[return]
