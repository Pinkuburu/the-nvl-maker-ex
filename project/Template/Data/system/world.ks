@if exp="typeof(global.world_object) == 'undefined'"
@iscript

KAGLoadScript('world.tjs');

kag.addPlugin(global.world_object = new KAGWorldPlugin(kag));
if (kag.debugLevel >= tkdlSimple) {
    dm("環境設定完了");
}

// 立繪表示確認用機能
if (debugWindowEnabled) {
	KAGLoadScript('standview.tjs');
}

@endscript
@endif

@return
