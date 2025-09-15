#!/bin/bash

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      고급 네트워크 진단 도구 v2.0      ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# 시스템 정보
echo -e "${BLUE}📋 시스템 정보${NC}"
echo "----------------------------------------"
echo "호스트명: $(hostname)"
echo "운영체제: $(uname -s) $(uname -r)"
echo "아키텍처: $(uname -m)"
echo "현재 시간: $(date)"
echo "사용자: $(whoami)"
echo "홈 디렉토리: $HOME"
echo ""

# 네트워크 인터페이스 정보
echo -e "${BLUE}🌐 네트워크 인터페이스${NC}"
echo "----------------------------------------"
if command -v ip >/dev/null 2>&1; then
    echo "활성 인터페이스:"
    ip addr show | grep -E "inet [0-9]" | while read line; do
        echo "  $line"
    done
elif command -v ifconfig >/dev/null 2>&1; then
    echo "활성 인터페이스:"
    ifconfig | grep -E "inet [0-9]" | while read line; do
        echo "  $line"
    done
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

echo "Cloudflare DNS (1.1.1.1) 테스트 중..."
if ping -c 2 -W 2 1.1.1.1 >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Cloudflare DNS 연결 정상${NC}"
else
    echo -e "${YELLOW}⚠ Cloudflare DNS 연결 불가${NC}"
fi
echo ""

# DNS 확인 (상세)
echo -e "${BLUE}🔍 DNS 서비스 테스트${NC}"
echo "----------------------------------------"
dns_servers=("google.com" "github.com" "stackoverflow.com")
for domain in "${dns_servers[@]}"; do
    echo "$domain DNS 조회 중..."
    if nslookup "$domain" >/dev/null 2>&1; then
        dns_result=$(nslookup "$domain" 2>/dev/null | grep "Address:" | tail -1)
        echo -e "${GREEN}✓ $domain 정상${NC}"
        echo "  IP 주소: $dns_result"
    else
        echo -e "${RED}✗ $domain 실패${NC}"
    fi
done
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
ports=("80" "443" "53" "993" "587")
for port in "${ports[@]}"; do
    case $port in
        80) service="HTTP";;
        443) service="HTTPS";;
        53) service="DNS";;
        993) service="IMAPS";;
        587) service="SMTP";;
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

# 웹 서비스 테스트
echo -e "${BLUE}🌐 웹 서비스 테스트${NC}"
echo "----------------------------------------"
web_services=("http://google.com" "https://github.com" "https://stackoverflow.com")
for url in "${web_services[@]}"; do
    echo "$url 연결 테스트 중..."
    if curl -s --connect-timeout 5 --max-time 10 "$url" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ $url 접근 가능${NC}"
    else
        echo -e "${YELLOW}⚠ $url 접근 불가${NC}"
    fi
done
echo ""

# 시스템 리소스 정보
echo -e "${BLUE}💻 시스템 리소스${NC}"
echo "----------------------------------------"
echo "메모리 사용량:"
if command -v free >/dev/null 2>&1; then
    free -h | head -2
elif command -v vm_stat >/dev/null 2>&1; then
    vm_stat | head -5
else
    echo "메모리 정보를 가져올 수 없습니다."
fi

echo ""
echo "디스크 사용량:"
if command -v df >/dev/null 2>&1; then
    df -h | head -5
else
    echo "디스크 정보를 가져올 수 없습니다."
fi
echo ""

# 요약
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}              진단 완료              ${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}모든 네트워크 진단이 완료되었습니다.${NC}"
echo "진단 시간: $(date)"
echo "스크립트 버전: v2.0"
echo ""
echo -e "${PURPLE}💡 추가 정보:${NC}"
echo "- 이 스크립트는 네트워크 연결 상태를 종합적으로 진단합니다"
echo "- 문제가 발견되면 네트워크 관리자에게 문의하세요"
echo "- 정기적인 네트워크 진단을 권장합니다"
echo ""