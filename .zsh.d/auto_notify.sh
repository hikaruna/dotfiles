# ある一定の時間以上かかるコマンドを実行した時通知するスクリプト
# 環境変数でカスタマイズ可能
# export AUTO_NOTIFY_TIME=3 # 時間の閾値
# export AUTO_NOTIFY_COMMAND=/ # 通知コマンド
# export AUTO_NOTIFY_IGNORE="vi less"/ # 無視するコマンド

BEGIN_TIME=0
function preexec_function() {
	BEGIN_TIME=`date +%s`
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_function

function precmd_function() {
	test $BEGIN_TIME -eq 0 && return

  precmd=`history | tail -n 1 | sed 's/^ *[0-9]* *//' | cut -d' ' -f 1`
	test "$precmd" = "vi" && return
	test "$precmd" = "less" && return
	test "$precmd" = "git" && return

	END_TIME=`date +%s`
	time=`expr $END_TIME - $BEGIN_TIME`
	if [ ${AUTO_NOTIFY_TIME:-3} -lt $time ];then
		if [ "${AUTO_NOTIFY_COMMAND:-UNDEF}" = "UNDEF" ];then
			if which terminal-notifier > /dev/null && terminal-notifier -version 2>/dev/null >/dev/null ; then
				terminal-notifier  -title "${precmd}" -message "${time} sec." -sound default -group owata > /dev/null
			else
				osascript -e 'beep'
			fi
		fi
	fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_function
