;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD <wang.siying@gmail.com>

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*window
[window_middle width=400 height=300 title="畫面特效設定"]
[check title="下雨" name="f.config_title.rain" x=30 y=50]
[check title="下雪" name="f.config_title.snow" x=30 y=80]
[check title="櫻花" name="f.config_title.sakura" x=30 y=110]
[check title="紅葉" name="f.config_title.momiji" x=30 y=140]
[check title="舊電影" name="f.config_title.movie" x=30 y=170]
[check title="螢火蟲" name="f.config_title.firefly" x=30 y=200]
[s]

*確認
[commit]


*關閉選單
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
