; 
; @waitfadech
; 　文字がすべてフェード終了するのを待つ。
; 　前行のフェードが終了しないうちに次行に行ってしまうこと、
; 　トランジションなどによってフェード中の文字が消えてしまうことを防ぐ。
; 
; 　行の終わりにあって別の処理が始まる直前のタグ、付属の first.ks なら
; [l] と [backlay] の直前に置けば動作する。
; 
; 　必要な箇所はおそらく [l] [p] [s] [backlay] の直前。
; 　一つあれば十分なので、マクロ中に
; ...[l][backlay]...
; 　のような箇所があれば、
; ...[waitfadech][l][backlay]...
; 　で良いです。
; 
; 　セミコロン(;)で下マクロの @waitfadech をコメントアウトして実行すれば、
; どのような動作になるかがわかると思います(特に「うに」のあたりで「不具合」が
; あらわれます)


@macro name="ld"
@waitfadech
@l
@endmacro

@macro name="backlaych"
@waitfadech
@backlay
@endmacro

; クリック待ちで改行。別に意味は無いです
@macro name="pgt"
@ld
@cm
@endmacro


@return
