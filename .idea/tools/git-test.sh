#!/bin/bash

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "네트워크 연결 테스트"
echo "===================="

# 인터넷 연결 확인
if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo -e "${GREEN}✓ 인터넷 연결 정상${NC}"
else
    echo -e "${RED}✗ 인터넷 연결 실패${NC}"
fi

# DNS 확인
if nslookup google.com >/dev/null 2>&1; then
    echo -e "${GREEN}✓ DNS 정상${NC}"
else
    echo -e "${RED}✗ DNS 실패${NC}"
fi

# 로컬 연결 확인
if ping -c 1 localhost >/dev/null 2>&1; then
    echo -e "${GREEN}✓ 로컬 연결 정상${NC}"
else
    echo -e "${RED}✗ 로컬 연결 실패${NC}"
fi