#!/bin/bash

# Cloudflare Pages 배포 스크립트

echo "🚀 BudgetLee Cloudflare Pages 배포 시작..."
echo ""

# 1. 환경변수 확인
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "❌ CLOUDFLARE_API_TOKEN 환경변수가 설정되지 않았습니다."
  echo ""
  echo "다음 명령어로 토큰을 설정하세요:"
  echo "export CLOUDFLARE_API_TOKEN='your-token-here'"
  echo ""
  exit 1
fi

echo "✅ Cloudflare API 토큰 확인됨"
echo ""

# 2. 인증 확인
echo "🔐 Cloudflare 인증 확인 중..."
npx wrangler whoami
if [ $? -ne 0 ]; then
  echo "❌ Cloudflare 인증 실패"
  exit 1
fi
echo ""

# 3. 빌드
echo "📦 프로젝트 빌드 중..."
npm run build
if [ $? -ne 0 ]; then
  echo "❌ 빌드 실패"
  exit 1
fi
echo "✅ 빌드 완료"
echo ""

# 4. D1 마이그레이션 (프로덕션)
echo "🗄️  D1 데이터베이스 마이그레이션 적용 중..."
npx wrangler d1 migrations apply webapp-production --remote
if [ $? -ne 0 ]; then
  echo "⚠️  마이그레이션 적용 실패 (계속 진행)"
fi
echo ""

# 5. Pages 배포
echo "🚀 Cloudflare Pages 배포 중..."
npx wrangler pages deploy dist --project-name budget-lee
if [ $? -ne 0 ]; then
  echo "❌ 배포 실패"
  exit 1
fi
echo ""

echo "✅ 배포 완료!"
echo ""
echo "🌐 사이트 URL:"
echo "   https://budget-lee.pages.dev"
echo "   https://main.budget-lee.pages.dev"
echo ""
echo "📊 다음 단계:"
echo "   1. JWT Secret 설정: npx wrangler pages secret put JWT_SECRET --project-name budget-lee"
echo "   2. 브라우저에서 사이트 접속 및 테스트"
echo ""
