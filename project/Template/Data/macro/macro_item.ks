;------------------------------------------------------------
;物品系統專用宏
;------------------------------------------------------------
[iscript]

f.abc=[
"測試1",
"測試2",
"測試3",
"測試4",
"測試5",
"測試6",
"測試7",
"測試8",
"測試9",
"測試10",
"測試11",
"測試12",
];

function draw_item()
{
	//描繪底板
//	var layer=kag.fore.layers[15];
//	layer.width=100;
//	layer.height=100;
//	layer.fillRect(0,0,100,100,0xFFFFFF,0);
	//layer.visible=true;
	kag.tagHandlers.image(%["storage" => "empty","visible" => true,"left"=>0,"top"=>0,"layer"=>"15","page"=>"fore"]);
	//寫字
	kag.fore.layers[15].font.height=25;
	
	dm("頁數："+f.index);
	
	for (var i=0;i<6;i++)
	{
		if (f.index+i>=f.abc.count) break;
		
		kag.fore.layers[15].drawText(100,100+i*25,f.abc[f.index+i],0xFFFFFF);
		dm(f.abc[f.index+i]);
	}

}

f.index=0;
[endscript]
;------------------------------------------------------------
[return]
