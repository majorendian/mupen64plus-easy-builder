#!/usr/local/bin/bash
target=projects/unix

cmd=$1
echo CMD $cmd
shift

j="-j2"
makecmd="make $j BITS=64 OPENCV=0 OSD=0"

URL_PREFIX=https://github.com/mupen64plus/

if [[ `id -u` != 0 ]]; then
	echo Must be root
	exit 1
fi
for repo in `cat REPOS`; do
	if [[ $cmd == "fetch" ]]; then
		git clone ${URL_PREFIX}${repo}
		continue
	elif [[ $cmd == "unlink" ]]; then
		rm -fr $repo
		continue
	elif [[ $cmd == "refetch" ]]; then
		rm -fr $repo
		git clone ${URPL_PREFIX}${repo}
		continue
	fi
	pushd $repo
		pushd $target
			if [[ $cmd == "clean" ]]; then
				$makecmd clean
			elif [[ $cmd == "remove" ]]; then
				$makecmd uninstall
				$makecmd clean
			elif [[ $cmd == "repo-reset-hard" ]]; then
				$makecmd uninstall
				$makecmd clean
				git reset --hard
			elif [[ $cmd == "reinstall" ]]; then
				$makecmd uninstall
				$makecmd clean
				$makecmd all
				$makecmd install
			elif [[ $cmd == "rebuild" ]]; then
				$makecmd clean
				$makecmd all
				$makecmd install
			elif [[ $cmd == "" ]]; then
				$makecmd all
				$makecmd install
				$makecmd clean
			elif [[ $cmd == "dbg" ]]; then
				$makecmd uninstall
				$makecmd clean
				$makecmd DEBUG=1 CORE_DBG=1 all
				$makecmd install
			fi

		popd
		echo === Done with $repo ===
	popd
done
