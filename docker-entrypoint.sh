#!/bin/sh

set -e

cert_name=minica.pem
key_name=minica-key.pem
result_dir=""
out_dir=/output
force=false

for arg do
	shift
	if [ "${arg#-force}" != "$arg" ]; then
		force=true
		continue
	fi
	if [ "${arg#-ca-cert}" != "$arg" ]; then
		cert_name=$1
	fi
	if [ "${arg#-ca-key}" != "$arg" ]; then
		key_name=$1
	fi
	if [ "${arg#-domains}" != "$arg" ]; then
		result_dir="$(echo "$1" | cut -d ',' -f1)"
		out_dir="/output/$result_dir"
	fi
	set -- "$@" "$arg"
done

if ! eval $force && [ -f "$out_dir/cert.pem" -o -f "$out_dir/key.pem" ]; then
	>&2 echo "Cannot overwrite existing files. Consider using -force."
	exit 1
fi

[ -f "/output/$cert_name" ] && ln -s "/output/$cert_name" "$cert_name"
[ -f "/output/$key_name" ] && ln -s "/output/$key_name" "$key_name"

/usr/local/bin/minica "$@" || eval "echo -e '  -force\n        Force overwrite'; exit $?"

[ ! -f "/output/$cert_name" ] && cp "$cert_name" "/output/$cert_name"
[ ! -f "/output/$key_name" ] && cp "$key_name" "/output/$key_name"
[ -d "$out_dir" ] || mkdir "$out_dir"
cp -f "$result_dir"/* "$out_dir"
