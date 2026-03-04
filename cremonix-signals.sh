#!/usr/bin/env bash
# Cremonix Signals Skill - OpenClaw Wrapper
# Auto-detects free vs paid tier based on API key configuration

set -euo pipefail

# Check for API key (multiple sources)
API_KEY="${CREMONIX_API_KEY:-}"

# Try OpenClaw config if env var not set
if [ -z "$API_KEY" ]; then
  OPENCLAW_CONFIG="$HOME/.openclaw/openclaw.json"
  if [ -f "$OPENCLAW_CONFIG" ]; then
    API_KEY=$(jq -r '.plugins.cremonix.config.apiKey // empty' "$OPENCLAW_CONFIG" 2>/dev/null || echo "")
  fi
fi

# Fetch data based on tier
if [ -n "$API_KEY" ]; then
  # PAID TIER: Use authenticated endpoint
  response=$(curl -s -H "Authorization: Bearer $API_KEY" \
    "https://app.cremonix.com/api/signals" 2>/dev/null || echo '{"error": "API request failed"}')
  
  # Check if API key is invalid/expired
  if echo "$response" | jq -e '.error' >/dev/null 2>&1; then
    error_msg=$(echo "$response" | jq -r '.error')
    echo "⚠️  API Error: $error_msg" >&2
    echo "" >&2
    echo "📋 Your API key may be expired or invalid." >&2
    echo "   Renew at: https://app.cremonix.com/billing" >&2
    echo "" >&2
    echo "💡 Falling back to free tier..." >&2
    # Fall back to free
    response=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json")
  fi
else
  # FREE TIER: Use public endpoint
  response=$(curl -s "https://blog.cremonix.com/feeds/cremonix-free.json")
fi

# Output the response
echo "$response"

# If using free tier, show upgrade info
if [ -z "$API_KEY" ] || echo "$response" | jq -e '.tier == "free" or .delay_hours == 4' >/dev/null 2>&1; then
  echo "" >&2
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
  echo "💎 UPGRADE TO REAL-TIME SIGNALS" >&2
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
  echo "" >&2
  echo "🆓 Free tier: 4-hour delayed signals" >&2
  echo "💎 Paid tier: Real-time signals ($25/month)" >&2
  echo "" >&2
  echo "⚡ Lightning: Instant, anonymous, $25.02" >&2
  echo "💳 Card: Auto-renewal, $25.73" >&2
  echo "" >&2
  echo "🔗 Upgrade: https://app.cremonix.com/api-subscribe" >&2
  echo "" >&2
  echo "🤖 For agents:" >&2
  echo '   curl -X POST https://app.cremonix.com/api-subscribe/create \' >&2
  echo '     -H "Content-Type: application/json" \' >&2
  echo '     -d '"'"'{"user_type": "agent", "tier": "paid", "payment_method": "lightning"}'"'"' >&2
  echo "" >&2
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
fi
