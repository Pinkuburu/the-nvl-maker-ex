;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;編輯器設定
;---------------------------------------------------------------
*window
[window_up width=450 height=200 title="默認打開"]
[line title="工程" name="sf.project" x=30 y=50]
[s]

*確認
[commit]

*關閉選單
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[jump storage="first.ks" target=*window]
