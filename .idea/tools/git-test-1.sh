#!/bin/bash

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}        상세 네트워크 연결 테스트        ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# 시스템 정보
echo -e "${BLUE}📋 시스템 정보${NC}"
echo "----------------------------------------"
echo "호스트명: $(hostname)"
echo "운영체제: $(uname -s) $(uname -r)"
echo "현재 시간: $(date)"
echo "사용자: $(whoami)"
echo ""

# 네트워크 인터페이스 정보
echo -e "${BLUE}🌐 네트워크 인터페이스${NC}"
echo "----------------------------------------"
if command -v ip >/dev/null 2>&1; then
    ip addr show | grep -E "inet [0-9]" | head -3
elif command -v ifconfig >/dev/null 2>&1; then
    ifconfig | grep -E "inet [0-9]" | head -3
else
    echo "네트워크 인터페이스 정보를 가져올 수 없습니다."
fi
echo ""

# 인터넷 연결 확인 (상세)
echo -e "${BLUE}🌍 인터넷 연결 테스트${NC}"
echo "----------------------------------------"
echo "Google DNS (8.8.8.8) 테스트 중..."
if ping -c 3 -W 2 8.8.8.8 >/dev/null 2>&1; then
    ping_result=$(ping -c 3 8.8.8.8 2>/dev/null | tail -1)
    echo -e "${GREEN}✓ 인터넷 연결 정상${NC}"
    echo "  응답 시간: $ping_result"
else
    echo -e "${RED}✗ 인터넷 연결 실패${NC}"
fi
echo ""

# DNS 확인 (상세)
echo -e "${BLUE}🔍 DNS 서비스 테스트${NC}"
echo "----------------------------------------"
echo "Google.com DNS 조회 중..."
if nslookup google.com >/dev/null 2>&1; then
    dns_result=$(nslookup google.com 2>/dev/null | grep "Address:" | tail -1)
    echo -e "${GREEN}✓ DNS 정상${NC}"
    echo "  IP 주소: $dns_result"
else
    echo -e "${RED}✗ DNS 실패${NC}"
fi
echo ""

# 로컬 연결 확인
echo -e "${BLUE}🏠 로컬 연결 테스트${NC}"
echo "----------------------------------------"
echo "localhost 연결 테스트 중..."
if ping -c 1 -W 2 localhost >/dev/null 2>&1; then
    echo -e "${GREEN}✓ 로컬 연결 정상${NC}"
else
    echo -e "${RED}✗ 로컬 연결 실패${NC}"
fi
echo ""

# 포트 연결 테스트
echo -e "${BLUE}🔌 포트 연결 테스트${NC}"
echo "----------------------------------------"
ports=("80" "443" "53")
for port in "${ports[@]}"; do
    case $port in
        80) service="HTTP";;
        443) service="HTTPS";;
        53) service="DNS";;
    esac
    
    if nc -z -w2 google.com $port 2>/dev/null; then
        echo -e "${GREEN}✓ 포트 $port ($service) 연결 가능${NC}"
    else
        echo -e "${YELLOW}⚠ 포트 $port ($service) 연결 불가${NC}"
    fi
done
echo ""

# 라우팅 테스트
echo -e "${BLUE}🛣️  라우팅 테스트${NC}"
echo "----------------------------------------"
echo "기본 게이트웨이 확인 중..."
if command -v ip >/dev/null 2>&1; then
    gateway=$(ip route | grep default | head -1 | awk '{print $3}')
elif command -v route >/dev/null 2>&1; then
    gateway=$(route -n | grep '^0.0.0.0' | awk '{print $2}' | head -1)
else
    gateway="확인 불가"
fi

if [ "$gateway" != "확인 불가" ] && [ -n "$gateway" ]; then
    echo "기본 게이트웨이: $gateway"
    if ping -c 1 -W 2 "$gateway" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ 게이트웨이 연결 정상${NC}"
    else
        echo -e "${RED}✗ 게이트웨이 연결 실패${NC}"
    fi
else
    echo -e "${YELLOW}⚠ 게이트웨이 정보를 가져올 수 없습니다${NC}"
fi
echo ""

# 요약
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}              테스트 완료              ${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}모든 네트워크 테스트가 완료되었습니다.${NC}"
echo "테스트 시간: $(date)"
echo ""