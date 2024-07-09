#!/bin/bash -l

function usage {
cat >&2 <<EOS
[usage]
 $0 [options]

[options]
 -h | --help:
   ヘルプを表示
 --push:
   ECRにプッシュを行う
 --no-cache:
   キャッシュを使わないでビルド

[example]
 ビルドのみを実行する
 $0

 ビルドとECRへのプッシュを実行する
 $0 --push --no-cache
EOS
exit 1
}

AWS_REGION="ap-northeast-1"
PUSH=
BUILD_OPTIONS="--rm"
args=()
while [ "$#" != 0 ]; do
  case $1 in
    -h | --help  ) usage ;;
    --push       ) shift; PUSH=1 ;;
    --no-cache   ) BUILD_OPTIONS="$BUILD_OPTIONS --no-cache" ;;
    -* | --*     ) error "$1 : 不正なオプションです" ;;
    *            ) args+=("$1") ;;
  esac
  shift
done

[ "${#args[@]}" != 0 ] && usage

set -e
cd $CONTAINER_PROJECT_ROOT

# AWSアカウントIDの取得
AWS_ACCOUNT_ID=$(aws $AWS_PROFILE_OPTION sts get-caller-identity --query 'Account' --output text)

#############################
# イメージのbuild
#############################
REMOTE_IMAGE="$(cd ${CONTAINER_PROJECT_ROOT}/terraform; terraform output -raw grafana_ecr_repository)"
VERSION=$(date +"%Y%m%d.%H%M")

#!/bin/bash
docker build $BUILD_OPTIONS \
  -f docker/grafana/Dockerfile \
  -t eks-grafana/grafana:latest \
  -t $REMOTE_IMAGE:latest \
  -t $REMOTE_IMAGE:$VERSION \
  .

# ビルドのみの場合はここで終了
[ -z "$PUSH" ] && exit 0

#############################
# イメージのpush
#############################
# ECRログイン
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# push
docker push ${REMOTE_IMAGE}:latest
docker push ${REMOTE_IMAGE}:${VERSION}

echo "イメージのプッシュが完了しました。"
echo "IMAGE_URI: ${REMOTE_IMAGE}:${VERSION} (latest)"
