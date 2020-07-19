#! /bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

export PRUNE_LABEL="${PRUNE_LABEL}-$1"
TARGET="${SCRIPT_DIR}/$1"
MODE=$2

# generate settings at self dir
(
  cd ${TARGET}
  ./generate.sh
)

case $MODE in
  apply)
    kubectl apply -k ${TARGET} --prune -l pruneLabel=${PRUNE_LABEL}
  ;;
  diff)
    # kubectl diffは、差分がなくエラーもないときに0を返し
    # 差分があるか、エラーがあるときには1を返す
    # 1. 差分がでるだけでCircleCIとしてJobFailになるのは不味い
    # 2. しかしエラーがあるときにJobSuccessになるのも不味い
    # そこでエラーを事前にkubectl apply --server-dry-runによって検出し
    # diffはその後set +e(1が帰ってきても失敗扱いしない)で実行する。
    kubectl apply -k ${TARGET} --server-dry-run --prune -l pruneLabel=${PRUNE_LABEL}
    # ここまできたらエラーがあってもなくても強制的に成功扱いする
    set +e
    kubectl diff -k ${TARGET}
  ;;
  *)
    echo "Not implemented command '${MODE}'"
    exit 1
  ;;
esac

exit 0