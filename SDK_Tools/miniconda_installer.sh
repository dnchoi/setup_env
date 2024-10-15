#!/bin/bash

# 설치 경로를 첫 번째 인자로 받습니다.
INSTALL_PATH=$1

# 설치 경로가 제공되지 않은 경우 도움말 메시지 출력
if [ -z "$INSTALL_PATH" ]; then
    echo "사용법: $0 [설치 경로]"
    exit 1
fi

# Miniconda 설치 스크립트 이름
INSTALLER=Miniconda3-latest-Linux-x86_64.sh

# Miniconda 다운로드 URL
URL=https://repo.anaconda.com/miniconda/$INSTALLER

# 설치 스크립트 다운로드
echo "Miniconda 설치 스크립트를 다운로드합니다..."
wget $URL -O $INSTALLER

# 다운로드 성공 여부 확인
if [ $? -ne 0 ]; then
    echo "다운로드에 실패했습니다. URL을 확인하세요."
    exit 1
fi

# 설치 스크립트에 실행 권한 부여
chmod +x $INSTALLER

# Miniconda 설치
echo "Miniconda를 $INSTALL_PATH 경로에 설치합니다..."
./$INSTALLER -b -p $INSTALL_PATH

# 설치 성공 여부 확인
if [ $? -ne 0 ]; then
    echo "Miniconda 설치에 실패했습니다."
    exit 1
fi

# 환경 변수 설정 (현재 세션에만 적용)
export PATH="$INSTALL_PATH/bin:$PATH"

# 설치 완료 메시지
echo "Miniconda가 $INSTALL_PATH 경로에 성공적으로 설치되었습니다."

# 설치 스크립트 제거 (선택 사항)
rm $INSTALLER

# 설치 확인
echo "Conda 버전을 확인합니다..."
conda --version
