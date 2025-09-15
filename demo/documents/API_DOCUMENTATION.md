# API 문서

이 문서는 Demo 프로젝트의 REST API 전체에 대한 상세한 문서입니다. 클라이언트 개발자가 API를 사용할 수 있도록 요청/응답 형태와 예시를 포함합니다.

## 목차

1. [기본 정보](#기본-정보)
2. [사용자 API](#사용자-api)
3. [상품 API](#상품-api)
4. [프로모션 API](#프로모션-api)
5. [장바구니 API](#장바구니-api)
6. [공통 응답 코드](#공통-응답-코드)
7. [데이터 타입 정의](#데이터-타입-정의)

## 기본 정보

- **Base URL**: `http://localhost:8080`
- **Content-Type**: `application/json`
- **인코딩**: UTF-8

## 사용자 API

### 1. 사용자 생성

새로운 사용자를 생성합니다.

**Endpoint**: `POST /api/users`

**Request Body**:
```json
{
  "email": "user@example.com",
  "membershipLevel": "NEW",
  "isNewCustomer": true
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| email | String | ✓ | 사용자 이메일 주소 |
| membershipLevel | String | ✓ | 회원 등급 (NEW, REGULAR, VIP, PREMIUM) |
| isNewCustomer | Boolean | ✓ | 신규 고객 여부 |

**Response** (201 Created):
```json
{
  "id": 1,
  "email": "user@example.com",
  "membershipLevel": "NEW",
  "isNewCustomer": true,
  "createdAt": "2024-01-15T10:30:00"
}
```

**Response Fields**:
| 필드 | 타입 | 설명 |
|------|------|------|
| id | Long | 생성된 사용자 ID |
| email | String | 사용자 이메일 주소 |
| membershipLevel | String | 회원 등급 |
| isNewCustomer | Boolean | 신규 고객 여부 |
| createdAt | LocalDateTime | 생성 일시 |

### 2. 사용자 조회

특정 사용자의 상세 정보를 조회합니다.

**Endpoint**: `GET /api/users/{id}`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 사용자 ID |

**Response** (200 OK):
```json
{
  "id": 1,
  "email": "user@example.com",
  "membershipLevel": "VIP",
  "isNewCustomer": false,
  "createdAt": "2024-01-15T10:30:00"
}
```

## 상품 API

### 1. 상품 생성

새로운 상품을 생성합니다.

**Endpoint**: `POST /api/products`

**Request Body**:
```json
{
  "name": "스마트폰",
  "description": "최신 스마트폰",
  "price": 999000.00,
  "stock": 100,
  "category": "전자제품",
  "brand": "삼성",
  "imageUrl": "https://example.com/image.jpg"
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| name | String | ✓ | 상품명 |
| description | String | | 상품 설명 |
| price | BigDecimal | ✓ | 상품 가격 |
| stock | Integer | ✓ | 재고 수량 |
| category | String | | 상품 카테고리 |
| brand | String | | 브랜드명 |
| imageUrl | String | | 상품 이미지 URL |

**Response** (201 Created):
```json
{
  "id": 1,
  "name": "스마트폰",
  "description": "최신 스마트폰",
  "price": 999000.00,
  "stock": 100,
  "category": "전자제품",
  "brand": "삼성",
  "imageUrl": "https://example.com/image.jpg",
  "isActive": true,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T10:30:00"
}
```

### 2. 상품 조회

특정 상품의 상세 정보를 조회합니다.

**Endpoint**: `GET /api/products/{id}`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 상품 ID |

**Response** (200 OK):
```json
{
  "id": 1,
  "name": "스마트폰",
  "description": "최신 스마트폰",
  "price": 999000.00,
  "stock": 100,
  "category": "전자제품",
  "brand": "삼성",
  "imageUrl": "https://example.com/image.jpg",
  "isActive": true,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T10:30:00"
}
```

### 3. 상품 목록 조회

모든 상품의 목록을 조회합니다.

**Endpoint**: `GET /api/products`

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "name": "스마트폰",
    "description": "최신 스마트폰",
    "price": 999000.00,
    "stock": 100,
    "category": "전자제품",
    "brand": "삼성",
    "imageUrl": "https://example.com/image.jpg",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00",
    "updatedAt": "2024-01-15T10:30:00"
  }
]
```

### 4. 상품 검색

카테고리나 키워드로 상품을 검색합니다.

**Endpoint**: `GET /api/products/search`

**Query Parameters**:
| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| category | String | | 상품 카테고리 |
| keyword | String | | 검색 키워드 |

**Example**: `GET /api/products/search?category=전자제품&keyword=스마트폰`

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "name": "스마트폰",
    "description": "최신 스마트폰",
    "price": 999000.00,
    "stock": 100,
    "category": "전자제품",
    "brand": "삼성",
    "imageUrl": "https://example.com/image.jpg",
    "isActive": true,
    "createdAt": "2024-01-15T10:30:00",
    "updatedAt": "2024-01-15T10:30:00"
  }
]
```

## 프로모션 API

### 1. 프로모션 생성

새로운 프로모션을 생성합니다.

**Endpoint**: `POST /api/promotions`

**Request Body**:
```json
{
  "name": "신규 회원 할인",
  "description": "신규 회원 10% 할인",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 1,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| name | String | ✓ | 프로모션명 |
| description | String | | 프로모션 설명 |
| type | String | ✓ | 프로모션 타입 |
| priority | Integer | ✓ | 우선순위 |
| startDate | LocalDateTime | ✓ | 시작 일시 |
| endDate | LocalDateTime | ✓ | 종료 일시 |
| targetCategory | String | | 대상 카테고리 |
| minCartAmount | BigDecimal | | 최소 장바구니 금액 |
| minQuantity | Integer | | 최소 수량 |
| targetUserLevel | String | | 대상 회원 등급 |
| discountPercentage | BigDecimal | | 할인율 (%) |
| discountAmount | BigDecimal | | 할인 금액 |
| maxDiscountAmount | BigDecimal | | 최대 할인 금액 |

**Response** (201 Created):
```json
{
  "promotionId": 1,
  "name": "신규 회원 할인",
  "description": "신규 회원 10% 할인",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 1,
  "isActive": true,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T10:30:00"
}
```

### 2. 프로모션 목록 조회

프로모션 목록을 조회합니다.

**Endpoint**: `GET /api/promotions`

**Query Parameters**:
| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| active | Boolean | | 활성화된 프로모션만 조회 |

**Example**: `GET /api/promotions?active=true`

**Response** (200 OK):
```json
[
  {
    "promotionId": 1,
    "name": "신규 회원 할인",
    "description": "신규 회원 10% 할인",
    "type": "PERCENTAGE_DISCOUNT",
    "priority": 1,
    "isActive": true,
    "startDate": "2024-01-01T00:00:00",
    "endDate": "2024-12-31T23:59:59",
    "targetCategory": "전자제품",
    "minCartAmount": 50000.00,
    "minQuantity": 1,
    "targetUserLevel": "NEW",
    "discountPercentage": 10.00,
    "discountAmount": null,
    "maxDiscountAmount": 100000.00,
    "createdAt": "2024-01-15T10:30:00",
    "updatedAt": "2024-01-15T10:30:00"
  }
]
```

### 3. 프로모션 상세 조회

특정 프로모션의 상세 정보를 조회합니다.

**Endpoint**: `GET /api/promotions/{id}`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 프로모션 ID |

**Response** (200 OK):
```json
{
  "promotionId": 1,
  "name": "신규 회원 할인",
  "description": "신규 회원 10% 할인",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 1,
  "isActive": true,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T10:30:00"
}
```

### 4. 프로모션 수정

프로모션 정보를 수정합니다.

**Endpoint**: `PUT /api/promotions/{id}`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 프로모션 ID |

**Request Body**:
```json
{
  "name": "수정된 프로모션명",
  "description": "수정된 설명",
  "priority": 2
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| name | String | | 프로모션명 |
| description | String | | 프로모션 설명 |
| priority | Integer | | 우선순위 |

**Response** (200 OK):
```json
{
  "promotionId": 1,
  "name": "수정된 프로모션명",
  "description": "수정된 설명",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 2,
  "isActive": true,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T11:00:00"
}
```

### 5. 프로모션 삭제

프로모션을 삭제합니다.

**Endpoint**: `DELETE /api/promotions/{id}`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 프로모션 ID |

**Response** (204 No Content):
```
(응답 본문 없음)
```

### 6. 프로모션 활성화

프로모션을 활성화합니다.

**Endpoint**: `POST /api/promotions/{id}/activate`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 프로모션 ID |

**Response** (200 OK):
```json
{
  "promotionId": 1,
  "name": "신규 회원 할인",
  "description": "신규 회원 10% 할인",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 1,
  "isActive": true,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T11:00:00"
}
```

### 7. 프로모션 비활성화

프로모션을 비활성화합니다.

**Endpoint**: `POST /api/promotions/{id}/deactivate`

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| id | Long | 프로모션 ID |

**Response** (200 OK):
```json
{
  "promotionId": 1,
  "name": "신규 회원 할인",
  "description": "신규 회원 10% 할인",
  "type": "PERCENTAGE_DISCOUNT",
  "priority": 1,
  "isActive": false,
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59",
  "targetCategory": "전자제품",
  "minCartAmount": 50000.00,
  "minQuantity": 1,
  "targetUserLevel": "NEW",
  "discountPercentage": 10.00,
  "discountAmount": null,
  "maxDiscountAmount": 100000.00,
  "createdAt": "2024-01-15T10:30:00",
  "updatedAt": "2024-01-15T11:00:00"
}
```

### 8. 프로모션 적용

장바구니에 프로모션을 적용합니다.

**Endpoint**: `POST /api/promotions/apply`

**Request Body**:
```json
{
  "cartId": 1,
  "userId": 1
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| cartId | Long | ✓ | 장바구니 ID |
| userId | Long | ✓ | 사용자 ID |

**Response** (200 OK):
```json
{
  "subtotal": 999000.00,
  "totalDiscount": 99900.00,
  "finalAmount": 899100.00,
  "appliedPromotions": [
    {
      "promotionId": 1,
      "promotionName": "신규 회원 할인",
      "discountAmount": 99900.00
    }
  ]
}
```

## 장바구니 API

### 1. 장바구니 총액 계산 (프로모션 적용)

장바구니의 총액을 계산하고 프로모션을 적용합니다.

**Endpoint**: `POST /api/cart/calculate-with-promotions`

**Request Body**:
```json
{
  "userId": 1,
  "items": [
    {
      "productId": 1,
      "quantity": 2
    },
    {
      "productId": 2,
      "quantity": 1
    }
  ]
}
```

**Request Fields**:
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| userId | Long | ✓ | 사용자 ID |
| items | Array | ✓ | 장바구니 아이템 목록 |
| items[].productId | Long | ✓ | 상품 ID |
| items[].quantity | Integer | ✓ | 수량 |

**Response** (200 OK):
```json
{
  "items": [
    {
      "productId": 1,
      "productName": "스마트폰",
      "unitPrice": 999000.00,
      "quantity": 2,
      "totalPrice": 1998000.00
    },
    {
      "productId": 2,
      "productName": "케이스",
      "unitPrice": 50000.00,
      "quantity": 1,
      "totalPrice": 50000.00
    }
  ],
  "subtotal": 2048000.00,
  "totalDiscount": 204800.00,
  "shippingFee": 3000.00,
  "finalAmount": 1846200.00,
  "appliedPromotions": [
    {
      "promotionId": 1,
      "promotionName": "신규 회원 할인",
      "discountAmount": 204800.00
    }
  ]
}
```

**Response Fields**:
| 필드 | 타입 | 설명 |
|------|------|------|
| items | Array | 장바구니 아이템 목록 |
| items[].productId | Long | 상품 ID |
| items[].productName | String | 상품명 |
| items[].unitPrice | BigDecimal | 단가 |
| items[].quantity | Integer | 수량 |
| items[].totalPrice | BigDecimal | 총 가격 |
| subtotal | BigDecimal | 소계 |
| totalDiscount | BigDecimal | 총 할인 금액 |
| shippingFee | BigDecimal | 배송비 |
| finalAmount | BigDecimal | 최종 결제 금액 |
| appliedPromotions | Array | 적용된 프로모션 목록 |
| appliedPromotions[].promotionId | Long | 프로모션 ID |
| appliedPromotions[].promotionName | String | 프로모션명 |
| appliedPromotions[].discountAmount | BigDecimal | 할인 금액 |

### 2. 장바구니 검증

장바구니의 유효성을 검증합니다.

**Endpoint**: `POST /api/cart/validate`

**Request Body**:
```json
{
  "userId": 1,
  "items": [
    {
      "productId": 1,
      "quantity": 2
    }
  ]
}
```

**Response** (200 OK):
```json
{
  "isValid": true,
  "errors": [],
  "warnings": [
    "재고가 부족할 수 있습니다."
  ]
}
```

**Response Fields**:
| 필드 | 타입 | 설명 |
|------|------|------|
| isValid | Boolean | 유효성 검증 결과 |
| errors | Array | 오류 메시지 목록 |
| warnings | Array | 경고 메시지 목록 |

## 공통 응답 코드

| HTTP 상태 코드 | 설명 |
|----------------|------|
| 200 OK | 요청 성공 |
| 201 Created | 리소스 생성 성공 |
| 204 No Content | 요청 성공 (응답 본문 없음) |
| 400 Bad Request | 잘못된 요청 |
| 404 Not Found | 리소스를 찾을 수 없음 |
| 500 Internal Server Error | 서버 내부 오류 |

## 데이터 타입 정의

### 회원 등급 (MembershipLevel)
- `NEW`: 신규 회원
- `REGULAR`: 일반 회원
- `VIP`: VIP 회원
- `PREMIUM`: 프리미엄 회원

### 프로모션 타입 (PromotionType)
- `PERCENTAGE_DISCOUNT`: 퍼센트 할인
- `FIXED_DISCOUNT`: 고정 금액 할인
- `FREE_SHIPPING`: 무료 배송
- `BUY_ONE_GET_ONE`: 1+1 프로모션

### 날짜/시간 형식
- **LocalDateTime**: `YYYY-MM-DDTHH:mm:ss` (예: `2024-01-15T10:30:00`)
- **BigDecimal**: 소수점 2자리까지 지원 (예: `999000.00`)

## 에러 응답 예시

### 400 Bad Request
```json
{
  "error": "Bad Request",
  "message": "잘못된 요청입니다.",
  "timestamp": "2024-01-15T10:30:00"
}
```

### 404 Not Found
```json
{
  "error": "Not Found",
  "message": "요청한 리소스를 찾을 수 없습니다.",
  "timestamp": "2024-01-15T10:30:00"
}
```

### 500 Internal Server Error
```json
{
  "error": "Internal Server Error",
  "message": "서버 내부 오류가 발생했습니다.",
  "timestamp": "2024-01-15T10:30:00"
}
```

## 사용 예시

### 1. 사용자 생성 후 상품 조회
```bash
# 1. 사용자 생성
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "membershipLevel": "NEW",
    "isNewCustomer": true
  }'

# 2. 상품 목록 조회
curl -X GET http://localhost:8080/api/products

# 3. 장바구니 계산
curl -X POST http://localhost:8080/api/cart/calculate-with-promotions \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "items": [
      {
        "productId": 1,
        "quantity": 1
      }
    ]
  }'
```

### 2. 프로모션 생성 및 적용
```bash
# 1. 프로모션 생성
curl -X POST http://localhost:8080/api/promotions \
  -H "Content-Type: application/json" \
  -d '{
    "name": "신규 회원 할인",
    "description": "신규 회원 10% 할인",
    "type": "PERCENTAGE_DISCOUNT",
    "priority": 1,
    "startDate": "2024-01-01T00:00:00",
    "endDate": "2024-12-31T23:59:59",
    "targetUserLevel": "NEW",
    "discountPercentage": 10.00,
    "maxDiscountAmount": 100000.00
  }'

# 2. 프로모션 적용
curl -X POST http://localhost:8080/api/promotions/apply \
  -H "Content-Type: application/json" \
  -d '{
    "cartId": 1,
    "userId": 1
  }'
```

---

이 문서는 Demo 프로젝트의 모든 API 엔드포인트에 대한 상세한 정보를 제공합니다. 추가 질문이나 요청사항이 있으시면 개발팀에 문의해 주세요.